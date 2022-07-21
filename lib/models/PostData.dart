import 'Author.dart';

class PostData {
  final String id;
  final String content;
  final String createdAt;
  final Author author;
  final int likes;
  final int comments;
  final bool isLiked;

  const PostData({required this.id, required this.content, required this.createdAt, required this.author, required this.likes, required this.comments, required this.isLiked});

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
        id: json['id'],
        content: json['content'],
        createdAt: json['createdAt'],
        author: Author.fromJson(json['author']),
        likes: json['likes'],
        comments: json['comments'],
        isLiked: json['isLiked']
    );
  }
}