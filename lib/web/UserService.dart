import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



Future<UserStats> fetchConnectedUserStats() async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.get(
    Uri.parse("https://coding-pool-api.herokuapp.com/users/me"),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  Map<String, dynamic> map = jsonDecode(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeess user stats');

    return UserStats.fromJson(map);

  } else {
    throw Exception('Failed to fetch own stats');
  }
}

// à faire
Future<UserInfos> getConnectedUserInfos() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.get(
    Uri.parse("https://coding-pool-api.herokuapp.com/accounts/me"),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  Map<String, dynamic> map = jsonDecode(response.body);

  print(UserInfos.fromJson(map).username);

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeess');
    return UserInfos.fromJson(map) ;

  } else {
    throw Exception('Failed to fetch own infos');
  }
}



// OK

Future<void> changeUserPassword(ChangePassword changePassword) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.put(
    Uri.parse("https://coding-pool-api.herokuapp.com/accounts/me/password"),
    body: {'oldPassword': changePassword.oldPassword, 'newPassword': changePassword.newPassword, 'confirmPassword': changePassword.confirmPassword},
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Success change password');
    return jsonDecode(response.body) ;
  } else {
    throw Exception('Failed to change password');
  }
}


// ne fonctionne pas

Future<void> changeUserInfos(String username, String wallet, String email) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.put(
    Uri.parse("https://coding-pool-api.herokuapp.com/accounts/me"),
    body: {'username': username, 'wallet': wallet, 'email': email},
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Success change user infos');
    return jsonDecode(response.body) ;
  }
  else {
    throw Exception('Failed to change user infos');
  }
}

Future<bool> checkUsername(String username) async {

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.get(
    Uri.parse("https://coding-pool-api.herokuapp.com/accounts/check-username/" + username),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeess');
    return jsonDecode(response.body) ;
  }
  else {
    throw Exception('Failed to check username');
  }
}