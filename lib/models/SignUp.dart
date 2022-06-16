class UserSignUp {
  final String email;
  final String username;
  final String password;

  const UserSignUp({
    required this.email,
    required this.username,
    required this.password,
  });

  factory UserSignUp.fromJson(Map<String, dynamic> json) {
    return UserSignUp(email: json['email'], username: json['username'], password: json['email']);
  }
}
