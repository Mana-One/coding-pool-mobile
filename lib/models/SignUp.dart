import 'dart:io';

class UserSignUp {
  final String email;
  final String username;
  final String password;
  final File picture;

  const UserSignUp({
    required this.email,
    required this.username,
    required this.password,
    required this.picture
  });

  factory UserSignUp.fromJson(Map<String, dynamic> json) {
    return UserSignUp(email: json['email'], username: json['username'], password: json['email'], picture: json['picture']);
  }
}
