import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Models.dart';
import 'package:coding_pool_v0/models/Globals.dart' as globals;

Future<String> signIn(UserSignIn user) async {
  final response = await http.post(
      Uri.parse("https://coding-pool-api.herokuapp.com/auth/login"),
      body: { 'email': user.email, 'password': user.password}
  );
  Map<String, dynamic> map = jsonDecode(response.body);

  final prefs = await SharedPreferences.getInstance();
  prefs.setString('token', map['access_token']);

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Success Login');
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to sign in');
  }
}

Future<void> signUp(UserSignUp userSignUp) async {
  final response = await http.post(
      Uri.parse("https://coding-pool-api.herokuapp.com/accounts/register"),
      body: { 'email': userSignUp.email, 'username': userSignUp.username, 'password': userSignUp.password}
  );

  print(response.body);
  print(response.statusCode);

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Success sign up');
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to sign up');
  }
}

Future<bool> checkUsername(String username) async {

  bool isUsed;

  final response = await http.get(Uri.parse("https://coding-pool-api.herokuapp.com/accounts/check-username/" + username),);

  Map<String, dynamic> map = jsonDecode(response.body);

  isUsed = map['isUsernameUsed'];

  globals.isUsernameUsed = isUsed;

  if (response.statusCode == 200 || response.statusCode == 201) {
    print(isUsed.toString());
    return isUsed ;
  }
  else {
    throw Exception('Failed to check username');
  }
}