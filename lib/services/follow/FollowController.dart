import 'dart:convert';

import 'package:coding_pool_v0/services/follow/FollowService.dart';

class FollowController {
  FollowController();

  FollowService followService = FollowService();

  Future<void> followUser(String userId) async {
    final response = await followService.followUser(userId);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success follow user');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to follow user');
    }
  }

  Future<void> unfollowUser(String userId) async {
    final response = await followService.unfollowUser(userId);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success unfollow user');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to unfollow user');
    }
  }
}
