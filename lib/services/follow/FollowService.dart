import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class FollowService {
  FollowService();

  Future<http.Response> followUser(String userId) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse("https://coding-pool-api.herokuapp.com/users/follow/" + userId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> unfollowUser(String publicationId) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse("https://coding-pool-api.herokuapp.com/users/unfollow/" + publicationId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    return response;
  }

}