import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/services/post/PostService.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostController {
  PostController();
  PostService postService = PostService();

  Future<void> createPost(String content) async {

    final response = await postService.createPost(content);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Succeeeeeeeess create post');
      return jsonDecode(response.body) ;
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<dynamic> fetchConnectedUserTimeline() async {
    List<PostData> posts = [];

    final response = await postService.fetchConnectedUserTimeline();

    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      PostData postData = PostData.fromJson(mapPost);
      print(postData.content);
      posts.add(postData);
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Succeeeeeeeess fetch my timeline');
      return jsonDecode(response.body) ;
    } else {
      throw Exception('Failed to fetch own timeline');
    }
  }

  Future<dynamic> fetchUserTimeline(String userId) async {
    List<PostData> posts = [];

    final response = await postService.fetchUserTimeline(userId);

    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      PostData postData = PostData.fromJson(mapPost);
      print(postData.content);
      posts.add(postData);
    }

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Success user account');
      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to fetch user timeline');
    }
  }

  Future<dynamic> fetchHomeTimeline() async {

    List<PostData> posts = [];

    final response = await postService.fetchHomeTimeline();

    Map<String, dynamic> map = jsonDecode(response.body);
    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      PostData postData = PostData.fromJson(mapPost);
      posts.add(postData);
    }

  if (response.statusCode == 200 || response.statusCode == 201) {
      print('succeeeess fetch home timeline');
      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to fetch home timeline');
    }
  }

}