class Author {
  final String id;
  final String username;

  const Author({required this.id, required this.username});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], username: json['username']);
  }

}