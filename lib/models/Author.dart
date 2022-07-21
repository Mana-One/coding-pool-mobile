class Author {
  final String id;
  final String username;
  final String picture;

  const Author({required this.id, required this.username, required this.picture});

  factory Author.fromJson(Map<String, dynamic> json) {
    if(json['picture'] == null) return Author(id: json['id'], username: json['username'], picture: 'https://i.pinimg.com/736x/59/0d/1e/590d1e8463e03b9b5f413000c807f41b.jpg');
    return Author(id: json['id'], username: json['username'], picture: json['picture']);
  }

}