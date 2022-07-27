import 'dart:io';
import 'package:coding_pool_v0/models/ChangePassword.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  UserService();

  String url = "https://api.coding-pool.ovh/";

  Future<http.Response> getConnectedUserStats() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url + "users/me"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> getUserStats(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url + "users/" + userId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> getConnectedUserInfos() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url + "accounts/me"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> changeUserPassword(
      ChangePassword changePassword) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(url + "accounts/me/password"),
      body: {
        'oldPassword': changePassword.oldPassword,
        'newPassword': changePassword.newPassword,
        'confirmPassword': changePassword.confirmPassword
      },
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token.toString(),
      },
    );
    return response;
  }

  Future<http.StreamedResponse> changeUserInfos(
      String username, String email, String picture) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest('PUT', Uri.parse(url + "accounts/me"));
    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data"
    });
    request.fields['username'] = username;
    request.fields['email'] = email;

    if (picture != '') {
      request.files.add(await http.MultipartFile.fromPath(
        'picture',
        picture,
      ));
    } else {
      request.fields['picture'] = '';
    }

    var response = await request.send();
    return response;
  }
}
