class UserInfos {
  final String id;
  final String username;
  final String picture;
  final String email;
  final String role;

  const UserInfos({required this.id, required this.username, required this.picture, required this.email, required this.role});

  factory UserInfos.fromJson(Map<String, dynamic> json) {
    return UserInfos(
      id: json['id'],
      username: json['username'],
      picture: json['picture'],
      email: json['email'],
      role: json['role'],
    );
  }
}