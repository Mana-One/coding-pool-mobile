class Author {
  final String id;
  final String username;
  final String picture;

  const Author({required this.id, required this.username, required this.picture});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], username: json['username'], picture: json['picture']);
  }

}