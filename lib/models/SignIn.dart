class UserSignIn {
  final String email;
  final String password;

  const UserSignIn({
    required this.email,
    required this.password,
  });

  factory UserSignIn.fromJson(Map<String, dynamic> json) {
    return UserSignIn(email: json['email'], password: json['password'],);
  }
}