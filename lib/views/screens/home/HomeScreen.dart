import 'package:coding_pool_v0/models/PostData.dart';
import 'package:coding_pool_v0/services/post/PostController.dart';
import 'package:coding_pool_v0/views/widgets/PostWidget.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PostController postController = PostController();

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

    print('Home screen');

    return FutureBuilder(
        future: homePosts,
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
                color: Colors.orange,
              ));
        });

  }
}
