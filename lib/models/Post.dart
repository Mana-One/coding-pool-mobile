import 'PostData.dart';

class Post {
  final String id;
  final int total;
  final Uri? previous;
  final Uri? next;
  final List<PostData> data;

  const Post(
      {required this.id, required this.total, required this.previous, this.next, required this.data});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        total: json['total'],
        previous: json['title'],
        next: json['next'],
        data: json['data']
    );
  }
}