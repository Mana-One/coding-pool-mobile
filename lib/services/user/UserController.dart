import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/ChangePassword.dart';
import 'package:coding_pool_v0/models/UserStats.dart';
import 'package:coding_pool_v0/services/user/UserService.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/UserInfos.dart';

class UserController {
  UserController();
  UserService userService = UserService();

  Future<UserStats> getConnectedUserStats() async {

    print('user controller');

    final response = await userService.getConnectedUserStats();

    Map<String, dynamic> map;
    map = jsonDecode(response.body);
    return UserStats.fromJson(map);
  }

  Future<UserStats> getUserStats(String userId) async {

    final response = await userService.getUserStats(userId);
    Map<String, dynamic> map = jsonDecode(response.body);
    return UserStats.fromJson(map);

  }

  Future<UserInfos> getConnectedUserInfos() async {
    final response = await userService.getConnectedUserInfos();

    Map<String, dynamic> map = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess fetch connected user infos');
      return UserInfos.fromJson(map);

    } else {
      throw Exception('Failed to fetch own infos');
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

  Future<void> changeUserInfos(String username, String email, String picture) async {

    final response = await userService.changeUserInfos(username, email, picture);

    print(response.stream);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success change user infos');
    }
    else {
      throw Exception('Failed to change user infos');
    }
  }

}