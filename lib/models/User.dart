class User {
  final String id;
  final String username;
  final String picture;

  const User({
    required this.id,
    required this.username,
    required this.picture
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], username: json['username'], picture: json['picture']);
  }
}