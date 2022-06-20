import 'package:coding_pool_v0/models/SignIn.dart';
import 'package:coding_pool_v0/models/SignUp.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  AuthenticationService();

  Future<http.Response> signIn(UserSignIn user) async {
    final response = await http.post(
        Uri.parse("https://coding-pool-api.herokuapp.com/auth/login"),
        body: { 'email': user.email, 'password': user.password}
    );

    return response;
  }

  Future<http.Response> signUp(UserSignUp user) async {
    final response = await http.post(Uri.parse("https://coding-pool-api.herokuapp.com/accounts/register"),
        body: { 'email': user.email, 'username': user.username, 'password': user.password}
    );
    return response;
  }

  Future<http.Response> checkUsername(String username) async {
    final response = await http.get(Uri.parse("https://coding-pool-api.herokuapp.com/accounts/check-username/"));
    return response;
  }

}