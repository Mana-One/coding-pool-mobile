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
    if(json['picture'] == null) json['picture'] = 'https://i.pinimg.com/736x/59/0d/1e/590d1e8463e03b9b5f413000c807f41b.jpg';
    return User(id: json['id'], username: json['username'], picture: json['picture']);
  }
}