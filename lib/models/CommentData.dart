import 'Author.dart';

class CommentData {
  final String id;
  final String content;
  final String createdAt;
  final Author leftBy;

  const CommentData({required this.id, required this.content, required this.createdAt, required this.leftBy});

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      id: json['id'],
      content: json['content'],
      createdAt: json['createdAt'],
      leftBy: Author.fromJson(json['leftBy']),
    );
  }
}