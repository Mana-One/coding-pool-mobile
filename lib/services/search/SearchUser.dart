import '../../models/User.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchUser {

  void searchUser(String user) async {

    List<User> results = [];

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/users/search?username=$user&limit=20&offset=0"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    print(response.body);

    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapUsers = listResponse[i];
      User user = User.fromJson(mapUsers);
      results.add(user);
    }
/*
    setState(() {
      _users = results;
    });
*/
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch home timeline');
    }
  }

}