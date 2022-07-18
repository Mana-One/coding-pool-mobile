import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/ChangePassword.dart';
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

  Future<http.Response> updateUserInfos(String username, String email, File picture) async {

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

  Future<http.StreamedResponse> changeInfos(String username, String email, File picture) async {
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

  Future changeUserInfos(String username, String email, String picture) async {
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

  /*Future<http.StreamedResponse> changeUserInfos(String username, String email, File picture) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("PUT", Uri.parse("https://coding-pool-api.herokuapp.com/accounts/me"));
    request.headers.addAll({"Authorization": "Bearer " + token.toString()});
    //add text fields
    request.fields["username"] = username;
    request.fields["email"] = email;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("picture", picture.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    return response;
  }*/

  // _asyncFileUpload(String username, String email, File picture) async{
  //   //create multipart request for POST or PATCH method
  //   var request = http.MultipartRequest("PUT", Uri.parse("https://coding-pool-api.herokuapp.com/accounts/me"));
  //   request.headers.addAll({"Authorization": "Bearer " + token.toString()});
  //   //add text fields
  //   request.fields["username"] = username;
  //   request.fields["email"] = email;
  //   //create multipart using filepath, string or bytes
  //   var pic = await http.MultipartFile.fromPath("file_field", picture.path);
  //   //add multipart to request
  //   request.files.add(pic);
  //   var response = await request.send();
  //
  //   //Get the response from the server
  //   var responseData = await response.stream.toBytes();
  //   var responseString = String.fromCharCodes(responseData);
  //   print(responseString);
  // }

}