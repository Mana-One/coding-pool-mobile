import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FollowService {
  FollowService();

  String url = "https://api.coding-pool.ovh/";

  Future<http.Response> followUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse(url + "users/follow/" + userId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> unfollowUser(String publicationId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse(url + "users/unfollow/" + publicationId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      },
    );

    return response;
  }
}
