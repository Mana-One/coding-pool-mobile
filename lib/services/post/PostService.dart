import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coding_pool_v0/models/Globals.dart' as globals;

class PostService {
  PostService();

  String url = "https://api.coding-pool.ovh/";

  Future<http.Response> createPost(String content) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse(url + "publications"),
      body: {'content': content},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> deletePost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse(url + "publications/" + postId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> fetchConnectedUserTimeline() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url + "publications/timeline/me?limit=20&offset=0"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> fetchUserTimeline(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url + "publications/timeline/$userId?limit=20&offset=0"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> fetchHomeTimeline() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url + "publications/timeline/home?limit=20&offset=0"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + globals.token.toString(),
      },
    );

    return response;
  }
}
