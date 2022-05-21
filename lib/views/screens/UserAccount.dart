import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/views/widgets/PostWidget.dart';
import 'package:coding_pool_v0/web/SocialNetworkService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class UserAccount extends StatefulWidget {
  const UserAccount(this.author);

  final Author author;
  @override
  State<UserAccount> createState() => _UserAccountState(this.author);
}

class _UserAccountState extends State<UserAccount> {

  final Author author;
  _UserAccountState(this.author);

  late final futurePost;
  late final futureStats;
  List<PostData> _postData = [];
  UserStats _userStats = UserStats(id: '', username: '', memberSince: '', followers: 0, following: 0, programs: 0, competitions_entered: 0, competitions_won: 0);

  Future<UserStats> getUserStats(String userId) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/users/" + userId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    Map<String, dynamic> map = jsonDecode(response.body);

    setState(() {
      _userStats = UserStats.fromJson(map);
    });

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess');
      return UserStats.fromJson(map);

    } else {
      throw Exception('Failed to get user stats');
    }

  }

  Future<dynamic> getUserPublications(String userId) async {
    List<PostData> posts = [];

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/publications/timeline/$userId?limit=20&offset=0"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      PostData postData = PostData.fromJson(mapPost);
      print(postData.content);
      posts.add(postData);
    }

    setState(() {
      _postData = posts;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Success user account');
      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to fetch user timeline');
    }
  }

  bool isFollowed = false;
  int nbFollowers = 0;

  @override
  void initState() {
    super.initState();
    futurePost =  getUserPublications(author.id);
    futureStats = getUserStats(author.id);
    nbFollowers = _userStats.followers;
    for(var post in _postData) {
      if(post.author.username == author.username) {
        this.isFollowed = true;
        return;
      }
    }
  }



  follow() {
    setState(() {
      if( isFollowed ) {
        this.isFollowed = false;
        unfollowUser(author.id);
        this.nbFollowers --;
      }
      else {
        this.isFollowed = true;
        followUser(author.id);
        this.nbFollowers ++;
      }
    });
    followUser('null');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blueGrey,Colors.grey]
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 220.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios, color: Colors.deepOrange[900], size: 30.0,),
                        ),
                      ),

                      Column(
                        children: [
                          Container(
                            width: 250,
                            child: svgLogoDeco,
                          ),

                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            author.username, style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white
                          ),
                          ),
                        ],
                      ),

                      Container(
                        margin: new EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            follow();
                          },
                          child: isFollowed ? Text('Unfollow') : Text('Follow'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange[900],
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),

                        ),
                      ),
                    ],
                  ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      margin: EdgeInsets.all(10.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all( 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      _postData.length.toString(),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                )
                            ),
                            Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      nbFollowers.toString(),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                )
                            ),
                            Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      _userStats.following.toString(),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for( var itemPost in _postData)
                      PostWidget(itemPost.id, itemPost.author, itemPost.content, itemPost.likes, itemPost.comments, itemPost.isLiked)
                  ],
                )
            ),
          ],
        )
    );
  }
}

final String assetName = 'lib/assets/images/frisePsi_original.svg';
final Widget svgLogoDeco = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo',
  height: 30,
  width: 80,
);