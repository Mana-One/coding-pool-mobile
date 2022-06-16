import 'CommentData.dart';

class Comment {
  final String id;
  final int total;
  final Uri? previous;
  final Uri? next;
  final List<CommentData> data;

  const Comment(
      {required this.id, required this.total, required this.previous, this.next, required this.data});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        total: json['total'],
        previous: json['title'],
        next: json['next'],
        data: json['data']
    );
  }
}