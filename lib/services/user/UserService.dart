import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/ChangePassword.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class UserService {
  UserService();

  String url = "https://api.coding-pool.ovh/";

  Future<http.Response> getConnectedUserStats() async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url + "users/me"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
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
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
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
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    return response;
  }

  Future<http.Response> changeUserPassword(ChangePassword changePassword) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(url + "accounts/me/password"),
      body: {'oldPassword': changePassword.oldPassword, 'newPassword': changePassword.newPassword, 'confirmPassword': changePassword.confirmPassword},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );
    return response;
  }

  Future<http.StreamedResponse> changeUserInfos(String username, String email, String picture) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest('PUT', Uri.parse(url + "accounts/me"));
    request.headers.addAll({"Authorization": "Bearer $token", "Content-type": "multipart/form-data"});
    request.fields['username'] = username;
    request.fields['email'] = email;

    if(picture != '') {
      request.files.add(
          await http.MultipartFile.fromPath(
            'picture',
            picture,
          )
      );
    } else {
      request.fields['picture'] = '';
    }

    var response = await request.send();
    return response;
  }

/*Future<http.Response> updateUserInfos(String username, String email, File picture) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(url + "accounts/me"),
      body: {'username': username, 'email': email, 'picture': picture},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },

    );

    print(response.body);

    return response;
  }
*/
  /*Future<http.StreamedResponse> changeInfos(String username, String email, File picture) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest('PUT', Uri.parse(url + "accounts/me"));
    if(picture != null ) {
      request.files.add(await http.MultipartFile.fromPath('file', picture.path, contentType: MediaType('image', 'jpg')));
    }
    request.fields['username'] = username;
    request.fields['email'] = email;
    request.headers.addAll({'Authorization': 'Bearer ' + token.toString()});

    var response = await request.send();

    print(picture.path);

    return response;

  }
*/

  /*Future changeUserInfos(String username, String email, String picture) async {
    var request = http.MultipartRequest('POST', Uri.parse(url + "accounts/me"));
    request.files.add(
        http.MultipartFile(
            'picture',
            File(picture).readAsBytes().asStream(),
            File(picture).lengthSync(),
            filename: picture.split("/").last
        )
    );
    var res = await request.send();
  }
  */

}