import 'package:coding_pool_v0/models/SignIn.dart';
import 'package:coding_pool_v0/models/SignUp.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  AuthenticationService();

  String url = "https://api.coding-pool.ovh/";

  Future<http.Response> signIn(UserSignIn user) async {
    final response = await http.post(
        Uri.parse(url + "auth/login"),
        body: { 'email': user.email, 'password': user.password}
    );

    return response;
  }

  Future<http.Response> signUp(UserSignUp user) async {
    final response = await http.post(Uri.parse(url + "accounts/register"),
        body: { 'email': user.email, 'username': user.username, 'password': user.password, 'picture': user.picture}
    );
    return response;
  }

  Future<http.Response> checkUsername(String username) async {
    final response = await http.get(Uri.parse(url + "accounts/check-username/"));
    return response;
  }

}