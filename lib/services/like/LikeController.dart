import 'dart:convert';
import 'package:coding_pool_v0/services/like/LikeService.dart';

class LikeController {
  LikeController();

  LikeService likeService = LikeService();

  Future<void> likePost(String postId) async {
    final response = await likeService.likePost(postId);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success like post');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to like post');
    }
  }

  Future<void> unlikePost(String postId) async {
    final response = await likeService.unlikePost(postId);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success unlike post');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to unlike post');
    }
  }
}
