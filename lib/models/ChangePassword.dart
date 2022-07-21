class ChangePassword {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePassword({required this.oldPassword, required this.newPassword, required this.confirmPassword});

  factory ChangePassword.fromJson(Map<String, dynamic> json) {
    return ChangePassword(
      oldPassword: json['oldPassword'],
      newPassword: json['newPassword'],
      confirmPassword: json['confirmPassword'],
    );
  }
}