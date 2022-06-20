import 'package:coding_pool_v0/services/post/PostController.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import '../../../models/PostData.dart';
import '../../widgets/PostWidget.dart';

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
              ? Scaffold(
            body: Column(
              children: [
                /*Container(
                  child: ElevatedButton(
                    child: Text('Add new post'),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PostCreationWidget()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
                  ),
                ),*/
                Container(
                  height: 660,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index){
                        return PostWidget(snapshot.data![index].id, snapshot.data![index].author, snapshot.data![index].content, snapshot.data![index].likes, snapshot.data![index].comments, snapshot.data![index].isLiked);
                      }
                  ),
                )
              ],
            ),
          )
              : Scaffold(
            body: Column(
              children: [
                Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.deepOrange,
                )
            )
              ],
            ),
          );
        });

  }
}
