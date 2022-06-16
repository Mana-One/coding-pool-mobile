import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<UserStats> getConnectedUserStats() async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/users/me"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    Map<String, dynamic> map = jsonDecode(response.body);

    print("following" + UserStats.fromJson(map).following.toString());
    print("following" + jsonDecode(response.body).toString());

    /*
    setState(() {
      _connectedUserStats = UserStats.fromJson(map);
    });
*/
    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess user stats');

      return UserStats.fromJson(map);

    } else {
      throw Exception('Failed to fetch own stats');
    }
  }

  Future<UserStats> getUserStats(String userId) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/users/" + userId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    Map<String, dynamic> map = jsonDecode(response.body);
/*
    setState(() {
      _userStats = UserStats.fromJson(map);
    });
*/
    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess');
      return UserStats.fromJson(map);

    } else {
      throw Exception('Failed to get user stats');
    }

  }

  Future<void> changeUserPassword(ChangePassword changePassword) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse("https://coding-pool-api.herokuapp.com/accounts/me/password"),
      body: {'oldPassword': changePassword.oldPassword, 'newPassword': changePassword.newPassword, 'confirmPassword': changePassword.confirmPassword},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Success change password');
      return jsonDecode(response.body) ;
    } else {
      throw Exception('Failed to change password');
    }
  }

  Future<void> changeUserInfos(String username, String wallet, String email) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse("https://coding-pool-api.herokuapp.com/accounts/me"),
      body: {'username': username, 'wallet': wallet, 'email': email},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Success change user infos');
      return jsonDecode(response.body) ;
    }
    else {
      throw Exception('Failed to change user infos');
    }
  }

}