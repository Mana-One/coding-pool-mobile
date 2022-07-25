import 'dart:convert';
import 'package:coding_pool_v0/models/PostData.dart';
import 'package:coding_pool_v0/services/post/PostService.dart';

class PostController {
  PostController();
  PostService postService = PostService();

  Future<void> createPost(String content) async {

    final response = await postService.createPost(content);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Succeess create post');
      return jsonDecode(response.body) ;
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<void> deletePost(String postId) async {

    final response = await postService.deletePost(postId);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success delete post');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete post');
    }
  }

  Future<List<PostData>> fetchConnectedUserTimeline() async {
    List<PostData> posts = [];

    final response = await postService.fetchConnectedUserTimeline();

    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      PostData postData = PostData.fromJson(mapPost);
      posts.add(postData);
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success fetch my timeline');
      return posts;
    } else {
      throw Exception('Failed to fetch own timeline');
    }
  }

  Future<int> getConnectedUserPostsNumber() async {
    int postsNb = 0;
    final response = await postService.fetchConnectedUserTimeline();
    Map<String, dynamic> map = jsonDecode(response.body);
    postsNb = map['total'] ;
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success get my posts number');
      return postsNb;
    } else {
      throw Exception('Failed to get own posts number');
    }
  }

  Future<List<PostData>> fetchUserTimeline(String userId) async {
    List<PostData> posts = [];

    final response = await postService.fetchUserTimeline(userId);

    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      PostData postData = PostData.fromJson(mapPost);
      posts.add(postData);
    }

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Success user account');
      return posts;

    } else {
      throw Exception('Failed to fetch user timeline');
    }
  }

  Future<int> getUserPostsNumber(String userId) async {
    int postsNb = 0;
    final response = await postService.fetchUserTimeline(userId);
    Map<String, dynamic> map = jsonDecode(response.body);
    postsNb = map['total'] ;
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success get posts number');
      return postsNb;
    } else {
      throw Exception('Failed to get posts number');
    }
  }

  Future<List<PostData>> fetchHomeTimeline() async {

    List<PostData> posts = [];

    final response = await postService.fetchHomeTimeline();

    Map<String, dynamic> map = jsonDecode(response.body);
    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      PostData postData = PostData.fromJson(mapPost);
      posts.add(postData);
    };

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('success fetch home timeline');
      return posts;
    } else {
      throw Exception('Failed to fetch home timeline');
    }
  }

}