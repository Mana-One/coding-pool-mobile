class UserInfos {
  final String id;
  final String username;
  final String wallet;
  final String email;
  final String role;

  const UserInfos({required this.id, required this.username, required this.wallet, required this.email, required this.role});

  factory UserInfos.fromJson(Map<String, dynamic> json) {
    return UserInfos(
      id: json['id'],
      username: json['username'],
      wallet: json['wallet'],
      email: json['email'],
      role: json['role'],
    );
  }
}