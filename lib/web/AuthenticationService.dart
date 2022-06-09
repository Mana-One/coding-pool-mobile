import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Models.dart';

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