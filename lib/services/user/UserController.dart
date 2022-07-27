import 'dart:convert';
import 'package:coding_pool_v0/models/ChangePassword.dart';
import 'package:coding_pool_v0/models/UserInfos.dart';
import 'package:coding_pool_v0/models/UserStats.dart';
import 'package:coding_pool_v0/services/user/UserService.dart';

class UserController {
  UserController();

  UserService userService = UserService();

  Future<UserStats> getConnectedUserStats() async {
    final response = await userService.getConnectedUserStats();

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return UserStats.fromJson(map);
    } else {
      throw Exception('Failed to fetch connected user stats');
    }
  }

  Future<UserStats> getUserStats(String userId) async {
    final response = await userService.getUserStats(userId);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return UserStats.fromJson(map);
    } else {
      throw Exception('Failed to fetch user stats');
    }
  }

  Future<UserInfos> getConnectedUserInfos() async {
    final response = await userService.getConnectedUserInfos();

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> map = jsonDecode(response.body);
      print('Success fetch connected user infos');
      return UserInfos.fromJson(map);
    } else {
      throw Exception('Failed to fetch connected user infos');
    }
  }

  Future<void> changeUserPassword(ChangePassword changePassword) async {
    final response = await userService.changeUserPassword(changePassword);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success change password');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to change password');
    }
  }

  Future<String> changeUserInfos(
      String username, String email, String picture) async {
    final response =
        await userService.changeUserInfos(username, email, picture);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success change user infos');
      return "OK";
    } else {
      throw Exception('Failed to change user infos');
    }
  }
}
