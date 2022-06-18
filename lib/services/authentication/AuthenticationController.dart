import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coding_pool_v0/models/Globals.dart' as globals;
import '../../models/Models.dart';
import 'AuthenticationService.dart';

class AuthenticationController with ChangeNotifier {
  AuthenticationController();
  AuthenticationService authenticationService = AuthenticationService();

  Future<String?> signIn(UserSignIn user) async {

    final response = await authenticationService.signIn(user);

    Map<String, dynamic> map = jsonDecode(response.body);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', map['access_token']);

    String? token = prefs.getString('access_token');

    if (response.statusCode == 200 || response.statusCode == 201) {
      globals.token = token;
      print('success signIn ' + globals.token.toString());
      return token;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<void> signUp(UserSignUp userSignUp) async {

    final response = await authenticationService.signUp(userSignUp);

    print(response.body);
    print(response.statusCode);
    print(userSignUp.username + userSignUp.email);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success sign up');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<bool> checkUsername(String username) async {

    bool isUsed;

    final response = await authenticationService.checkUsername(username);

    Map<String, dynamic> map = jsonDecode(response.body);
    isUsed = map['isUsernameUsed'];
    globals.isUsernameUsed = isUsed;

    if (response.statusCode == 200 || response.statusCode == 201) {
      return isUsed;
    }
    else {
      throw Exception('Failed to check username');
    }
  }

}