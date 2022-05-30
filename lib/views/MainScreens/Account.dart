import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/views/guest/SignIn.dart';
import 'package:coding_pool_v0/views/widgets/PostWidget.dart';
import 'package:coding_pool_v0/web/SocialNetworkService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../screens/CreateNewPost.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  late var futurePost;
  late var futureStats;
  UserStats _connectedserStats = UserStats(id: '', username: '', memberSince: '', followers: 0, following: 0, programs: 0, competitions_entered: 0, competitions_won: 0);
  List<PostData> _postData = [];

  Future<UserStats> getConnectedUserStats() async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/users/me"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    Map<String, dynamic> map = jsonDecode(response.body);

    print(UserStats.fromJson(map).username + 'mes statttttttt');

    setState(() {
      _connectedserStats = UserStats.fromJson(map);
    });

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess user stats');

      return UserStats.fromJson(map);

    } else {
      throw Exception('Failed to fetch own stats');
    }
  }

  Future<dynamic> getUserPublications() async {
    List<PostData> posts = [];

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/publications/timeline/me?limit=20&offset=0"),
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

      print('Succeeeeeeeess');
      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to fetch own timeline');
    }
  }

  @override
  void initState() {
    super.initState();
    futurePost =  getUserPublications();
    futureStats = getConnectedUserStats();
  }

  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    prefs.commit();
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  publishPost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewPost()));
  }

  late String username = '';

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                    ),
                    Column(
                      children: [
                        Container(
                          width: 200,
                          child: svgLogoNoText,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          _connectedserStats.username, style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white
                        ),
                        ),
                      ],
                    ),
                    Container(

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
                                    _connectedserStats.followers.toString(),
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
                                    _connectedserStats.following.toString(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: new EdgeInsets.only(left: 10, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    //publishPost();
                  },
                  child: Row(
                    children: [
                      Text('Post'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange[900],
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(right: 10, left: 15),
                child: ElevatedButton(
                  onPressed: () {
                    print(futureStats.toString());
                  },
                  child: Row(
                    children: [
                      Text('Stats'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange[900],
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),

                ),
              ),
              /*Container(
                margin: new EdgeInsets.only(right: 10, left: 15),
                child: ElevatedButton(
                  onPressed: () {
                    logout();
                  },
                  child: Row(
                    children: [
                      Text('Logout'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange[900],
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),

                ),
              ),*/
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            //flex: 1,
              child: ListView(
                shrinkWrap: true,
                children: [
                  for( var itemPost in _postData)
                    PostWidget(itemPost.id, itemPost.author, itemPost.content, itemPost.likes, itemPost.comments, itemPost.isLiked),
                ],
              )
          ),
        ],
      )
    );
  }
}

final String assetName = 'lib/assets/images/frisePsi_original.svg';
final Widget svgLogoNoText = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo',
  height: 50,
  width: 100,
);
