import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/viewss/screens/CreateNewPost.dart';
import 'package:flutter/material.dart';
import 'package:coding_pool_v0/viewss/widgets/PostWidget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'dart:io';

class HomeOld extends StatefulWidget {
  const HomeOld({Key? key}) : super(key: key);

  @override
  State<HomeOld> createState() => _HomeOldState();
}

class _HomeOldState extends State<HomeOld> {
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

    return Scaffold(
      body: Column(
          children: [
            Container(
              child: ElevatedButton(
                child: Text('Add new post'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewPost()));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
              ),
            ),
            Container(
              height: 600,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _postData.length,
                itemBuilder: (BuildContext context, int index){
                  return PostWidget(_postData[index].id, _postData[index].author, _postData[index].content, _postData[index].likes, _postData[index].comments, _postData[index].isLiked);

                }
            ),
            )
          ],
        ),
      );
  }
}

//ListView(
//       children: [
//         for( var itemPost in _postData)
//
//           PostWidget(username: itemPost.author.username, content: itemPost.content, nbLikes: itemPost.likes, nbComments: itemPost.comments, isLiked: itemPost.isLiked)
//       ],
//     );