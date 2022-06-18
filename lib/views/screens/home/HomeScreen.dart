import 'package:coding_pool_v0/services/post/PostController.dart';
import 'package:coding_pool_v0/services/post/PostService.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'dart:io';
import '../../../models/PostData.dart';
import '../../widgets/PostCreationWidget.dart';
import '../../widgets/PostWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PostController postController = PostController();

  late Future<List<PostData>> userPosts;

  late final futurePost;

  List<PostData> _postData = [];

  Future<dynamic> getPublications() async {
    List<PostData> posts = [];

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/publications/timeline/home?limit=20&offset=0"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      PostData postData = PostData.fromJson(mapPost);
      posts.add(postData);
    }

    setState(() {
      _postData = posts;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {

      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to fetch home timeline');
    }
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  @override
  void initState() {
    super.initState();
    futurePost =  getPublications();
    BackButtonInterceptor.add(myInterceptor);
    print(futurePost.toString());
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    userPosts = postController.fetchHomeTimeline();

    print('Home screen');

    return FutureBuilder(
        future: userPosts,
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
