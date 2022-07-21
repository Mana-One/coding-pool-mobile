import '../../models/User.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchService {
  SearchService();

  String url = "https://api.coding-pool.ovh/";

  Future<http.Response> searchUser(String user) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url + "users/search?username=$user&limit=20&offset=0"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    print("response search : " + response.body);

    return response;
  }

}