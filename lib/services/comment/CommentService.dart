import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../models/Comment.dart';
import '../../models/CommentData.dart';

class CommentService {
  Future<void> commentPost(String publicationId, String content) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse("https://coding-pool-api.herokuapp.com/comments"),
      body: {'content': content, 'publicationId': publicationId},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeesssssssssss');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to comment post');
    }
  }

  Future<void> UncommentPost(String commentId) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse("https://coding-pool-api.herokuapp.com/comments/" + commentId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeesssssssssss');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete post comment ');
    }
  }

  Future<Comment> getPublicationComments(String publicationId) async {
    List<CommentData> comments = [];

    //await recharge.init();

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/comments?limit=20&offset=0&publicationId=" + publicationId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    print(jsonDecode(response.body));

    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      CommentData comment = CommentData.fromJson(mapPost);
      print(comment.content);
      comments.add(comment);
    }
/*
    setState(() {
      _commentsData = comments;
    });
*/
    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Success get publication comments');
      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to fetch own timeline');
    }
  }
}