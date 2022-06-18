import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coding_pool_v0/models/Globals.dart' as globals;
import '../../models/Models.dart';

class AuthenticationService {
  AuthenticationService();

  Future<http.Response> signIn(UserSignIn user) async {
    final response = await http.post(Uri.parse("https://coding-pool-api.herokuapp.com/auth/login"));
    return response;
  }

  Future<http.Response> signUp(UserSignIn user) async {
    final response = await http.post(Uri.parse("https://coding-pool-api.herokuapp.com/auth/register"));
    return response;
  }

  Future<http.Response> checkUsername(String username) async {
    final response = await http.get(Uri.parse("https://coding-pool-api.herokuapp.com/accounts/check-username/"));
    return response;
  }

}