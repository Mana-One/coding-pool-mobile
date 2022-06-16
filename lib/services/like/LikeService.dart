import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class LikeService {
  Future<void> likePost(String publicationId) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse("https://coding-pool-api.herokuapp.com/likes/" + publicationId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to like post');
    }
  }

  Future<void> unlikePost(String publicationId) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse("https://coding-pool-api.herokuapp.com/likes/" + publicationId),
      body: { 'publicationId': publicationId},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeesssssssssss');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to unlike post');
    }
  }
}