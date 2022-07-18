import 'package:coding_pool_v0/models/Globals.dart';
import 'package:coding_pool_v0/models/PostData.dart';
import 'package:coding_pool_v0/models/UserStats.dart';
import 'package:coding_pool_v0/services/post/PostController.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/views/widgets/PostWidget.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreenTmp extends StatefulWidget {
  const HomeScreenTmp({Key? key}) : super(key: key);

  @override
  State<HomeScreenTmp> createState() => _HomeScreenTmpState();
}

class _HomeScreenTmpState extends State<HomeScreenTmp> {

  PostController postController = PostController();
  UserController userController = UserController();

  late Future<List<PostData>> connectedUserPosts;
  late Future<UserStats> connectedUserStats;
  late Future<int> connectedUserPostsNumber;

  late Future<List<PostData>> homePosts;

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!");
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

  @override
  Widget build(BuildContext context) {

    homePosts = postController.fetchHomeTimeline();
    connectedUserPosts = postController.fetchConnectedUserTimeline();
    connectedUserStats = userController.getConnectedUserStats();
    connectedUserPostsNumber = postController.getConnectedUserPostsNumber();

    print('Home screen');

    return Scaffold(
        body: Column(
          children: [
            FutureBuilder(
                future: connectedUserStats,
                builder: (BuildContext context,
                    AsyncSnapshot<UserStats> snapshot) {
                  return snapshot.data != null
                      ? Container(
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                    snapshot.data!.username, style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white
                                  ),
                                  ),
                                ],
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
                                          FutureBuilder(
                                              future: connectedUserPostsNumber,
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
                  )
                      : Container(
                    /*alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Color(3),
                        )*/
                  );
                }),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: new EdgeInsets.only(left: 10, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      //publishPost();
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
                  child: FutureBuilder(
                      future: connectedUserStats,
                      builder: (BuildContext context,
                          AsyncSnapshot<UserStats> snapshot) {
                        return snapshot.data != null
                            ? ElevatedButton(
                          onPressed: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => UserStatsScreen(userStats: snapshot.data as UserStats)));
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

                        )
                            : ElevatedButton(
                          onPressed: () {
                            //cNavigator.push(context, MaterialPageRoute(builder: (context) => ConnectedUserStats(userStats: snapshot.data as UserStats)));
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

                        );
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: FutureBuilder(
                  future: connectedUserPosts,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PostData>> snapshot) {
                    return snapshot.data != null
                        ? ListView(
                      children: [
                        for (var itemPost
                        in snapshot.data as List<PostData>)
                          PostWidget(itemPost.createdAt, itemPost.id, itemPost.author, itemPost.content, itemPost.likes, itemPost.comments, itemPost.isLiked),
                      ],
                    )
                        : Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Color(3),
                        ));
                  }),
            )
            /*Expanded(
            //flex: 1,
              child: ListView(
                shrinkWrap: true,
                children: [
                  for( var itemPost in posts)
                    PostWidget(itemPost.id, itemPost.author, itemPost.content, itemPost.likes, itemPost.comments, itemPost.isLiked),
                ],
              )
          ),*/
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
