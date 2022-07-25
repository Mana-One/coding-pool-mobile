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

  Future<http.StreamedResponse> signUp(UserSignUp user) async {

    var request = http.MultipartRequest('POST', Uri.parse(url + "accounts/register"));
    request.fields['username'] = user.username;
    request.fields['email'] = user.email;
    request.fields['password'] = user.password;
    request.fields['picture'] = '';
    var response = await request.send();
    print(response.statusCode);
    return response;
  }

  Future<http.Response> checkUsername(String username) async {
    final response = await http.get(Uri.parse(url + "accounts/check-username/" + username));
    return response;
  }

}