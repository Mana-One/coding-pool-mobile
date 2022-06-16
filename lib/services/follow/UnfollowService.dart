import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<void> unfollowUser(String publicationId) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.delete(
    Uri.parse("https://coding-pool-api.herokuapp.com/users/unfollow/" + publicationId),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeesssssssssss unfollow user');
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to unfollow user');
  }
}
