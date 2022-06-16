import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostService {

  Future<void> createPublication(String content) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse("https://coding-pool-api.herokuapp.com/publications"),
      body: {'content': content},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );


    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess user account');
      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to create publication');
    }
  }

  Future<dynamic> getConnectedUserPublications() async {
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
/*

    setState(() {
      _postData = posts;

    });
*/

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess');
      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to fetch own timeline');
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
/*
    setState(() {
      _postData = posts;
    });
*/
    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Success user account');
      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to fetch user timeline');
    }
  }


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
/*
    setState(() {
      _postData = posts;
    });
*/
    if (response.statusCode == 200 || response.statusCode == 201) {

      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to fetch home timeline');
    }
  }

}