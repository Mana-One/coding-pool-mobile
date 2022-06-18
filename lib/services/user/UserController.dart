import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/services/user/UserService.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  UserController();
  UserService userService = UserService();

  Future<UserStats> getConnectedUserStats() async {

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

  Future<void> changeUserPassword(ChangePassword changePassword) async {

    final response = await userService.changeUserPassword(changePassword);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success change password');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to change password');
    }
  }

  Future<void> changeUserInfos(String username, String wallet, String email) async {

    final response = await userService.changeUserInfos(username, wallet, email);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success change user infos');
      return jsonDecode(response.body) ;
    }
    else {
      throw Exception('Failed to change user infos');
    }
  }

}