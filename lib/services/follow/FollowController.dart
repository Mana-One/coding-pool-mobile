import 'package:coding_pool_v0/services/follow/FollowService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class FollowController {
  FollowController();
  FollowService followService = FollowService();

  Future<void> followUser(String userId) async {

    final response = await followService.followUser(userId);

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeesssssssssss follow user');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to follow user');
    }
  }

  Future<void> unfollowUser(String userId) async {

    final response = await followService.unfollowUser(userId);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Succeeeeeeeesssssssssss unfollow user');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to unfollow user');
    }
  }

}