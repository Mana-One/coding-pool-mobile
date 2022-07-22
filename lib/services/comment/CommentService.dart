import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../models/Comment.dart';
import '../../models/CommentData.dart';

class CommentService {
  CommentService();

  String url = "https://api.coding-pool.ovh/";

  Future<http.Response> commentPost(String publicationId, String content) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse(url + "comments"),
      body: {'content': content, 'publicationId': publicationId},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> uncommentPost(String commentId) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse(url + "comments/" + commentId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> getPublicationComments(String publicationId) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url + "comments?limit=20&offset=0&publicationId=" + publicationId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    return response;
  }
}