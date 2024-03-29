import 'dart:convert';
import 'package:coding_pool_v0/services/comment/CommentService.dart';
import '../../models/CommentData.dart';

class CommentController {
  CommentController();

  CommentService commentService = CommentService();

  Future<void> commentPost(String publicationId, String content) async {
    final response = await commentService.commentPost(publicationId, content);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success comment post');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to comment post');
    }
  }

  Future<void> uncommentPost(String commentId) async {
    final response = await commentService.uncommentPost(commentId);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success delete comment');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete post comment');
    }
  }

  Future<List<CommentData>> getPostComments(String publicationId) async {
    final response = await commentService.getPublicationComments(publicationId);

    Map<String, dynamic> map = jsonDecode(response.body);
    List<dynamic> listResponse = map['data'];
    List<CommentData> comments = [];

    for (int i = 0; i < listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      CommentData comment = CommentData.fromJson(mapPost);
      comments.add(comment);
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success get post comments');
      return comments;
    } else {
      throw Exception('Failed to fetch own timeline');
    }
  }
}
