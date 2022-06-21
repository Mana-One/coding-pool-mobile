import 'package:coding_pool_v0/models/Author.dart';
import 'package:coding_pool_v0/models/PostData.dart';
import 'package:coding_pool_v0/models/UserStats.dart';
import 'package:coding_pool_v0/services/follow/FollowController.dart';
import 'package:coding_pool_v0/services/post/PostController.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/views/Home.dart';
import 'package:coding_pool_v0/views/widgets/PostWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'UserStatsScreen.dart';


class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen(this.author);

  final Author author;

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState(this.author);
}

class _UserAccountScreenState extends State<UserAccountScreen> {

  UserController userController = UserController();
  PostController postController = PostController();
  FollowController followController = FollowController();

  late Future<List<PostData>> userPosts;
  late Future<UserStats> userStats;
  late Future<int> userPostsNumber;

  final Author author;
  _UserAccountScreenState(this.author);

  late final futurePost;
  late final futureStats;

  bool isFollowed = false;
  int nbFollowers = 0;

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }


  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }


  follow() {
    setState(() {
      if( isFollowed ) {
        this.isFollowed = false;
        followController.unfollowUser(author.id);
        this.nbFollowers --;
      }
      else {
        this.isFollowed = true;
        followController.followUser(author.id);
        this.nbFollowers ++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    userPosts = postController.fetchUserTimeline(this.author.id);
    userStats = userController.getUserStats(this.author.id);
    userPostsNumber = postController.getUserPostsNumber(this.author.id);

    print('user screen');

    return FutureBuilder(
        future: userStats,
        builder: (BuildContext context,
            AsyncSnapshot<UserStats> snapshot) {
          return snapshot.data != null
              ? Scaffold(
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
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                },
                                icon: Icon(Icons.home, color: Colors.deepOrange[900], size: 30.0,),
                              ),
                            )
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
                                          FutureBuilder(
                                              future: userPostsNumber,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<int> snapshot) {
                                                return snapshot.data != null
                                                    ? Text(
                                                  snapshot.data.toString(),
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey,
                                                  ),
                                                )
                                                    : Container(
                                                  /*alignment: Alignment.center,
                                                  child: const CircularProgressIndicator(
                                                    color: Color(3),
                                                  )*/);
                                              }),
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
                                            snapshot.data!.followers.toString(),
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
                                            snapshot.data!.following.toString(),
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
                        margin: new EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            if(snapshot.data!.isFollowing) {
                              this.isFollowed = true;
                            }
                            else {
                              this.isFollowed = false;
                            }
                            follow();
                          },
                          child: snapshot.data!.isFollowing ? Text('Unfollow') : Text('Follow'),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserStatsScreen(userStats: snapshot.data!)));
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
                    ],
                  ),
                  Expanded(
                      flex: 1,
                      child: FutureBuilder(
                          future: userPosts,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<PostData>> snapshot) {
                            return snapshot.data != null
                                ? ListView(
                              children: [
                                for (var itemPost
                                in snapshot.data as List<PostData>)
                                  PostWidget(itemPost.id, itemPost.author, itemPost.content, itemPost.likes, itemPost.comments, itemPost.isLiked),
                              ],
                            )
                                : Container(
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                  color: Color(3),
                                ));
                          }),
                  ),
                ],
              )
          )
              : Scaffold(
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
                            width: 40,
                          )
                        ],
                      ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Color(3),
                    )
                ),
              ],
            )

          );
        });
  }
}

final String assetName = 'lib/assets/images/frisePsi_original.svg';
final Widget svgLogoDeco = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo',
  height: 30,
  width: 80,
);
