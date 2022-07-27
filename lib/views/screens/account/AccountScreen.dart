import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:coding_pool_v0/models/PostData.dart';
import 'package:coding_pool_v0/models/UserStats.dart';
import 'package:coding_pool_v0/services/post/PostController.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/views/screens/account/UserStatsScreen.dart';
import 'package:coding_pool_v0/views/widgets/PostCreationWidget.dart';
import 'package:coding_pool_v0/views/widgets/PostWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserController userController = UserController();
  PostController postController = PostController();

  late Future<List<PostData>> connectedUserPosts;
  late Future<UserStats> connectedUserStats;
  late Future<int> connectedUserPostsNumber;

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
    connectedUserPosts = postController.fetchConnectedUserTimeline();
    connectedUserStats = userController.getConnectedUserStats();
    connectedUserPostsNumber = postController.getConnectedUserPostsNumber();

    print('Account screen');

    return Scaffold(
        body: Column(
      children: [
        FutureBuilder(
            future: connectedUserStats,
            builder: (BuildContext context, AsyncSnapshot<UserStats> snapshot) {
              //globals.connectedUserStats = snapshot.data!;
              return snapshot.hasData
                  ? Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.blueGrey, Colors.grey])),
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
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                            image: Image.network(
                                                    snapshot.data!.picture)
                                                .image,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      snapshot.data!.username,
                                      style: TextStyle(
                                          fontSize: 25.0, color: Colors.white),
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
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  : Container();
                                            }),
                                      ],
                                    )),
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
                                    )),
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
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ));
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: new EdgeInsets.only(left: 10, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  publishPost();
                },
                child: Row(
                  children: [
                    Text('Post'),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange[900],
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserStatsScreen(
                                          userStats:
                                              snapshot.data as UserStats
                                      )
                                  )
                              );
                            },
                            child: Row(
                              children: [
                                Text('Stats'),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange[900],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text('Stats'),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange[900],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                          for (var itemPost in snapshot.data as List<PostData>)
                            PostWidget(
                                itemPost.createdAt,
                                itemPost.id,
                                itemPost.author,
                                itemPost.content,
                                itemPost.likes,
                                itemPost.comments,
                                itemPost.isLiked),
                        ],
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Color(3),
                        ));
              }),
        )
      ],
    ));
  }
  publishPost() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostCreationWidget()));
  }
}
