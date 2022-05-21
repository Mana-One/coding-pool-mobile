import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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

    print('Succeeeeeeeess change password');
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

  print(username + wallet + email);

  if (response.statusCode == 200 || response.statusCode == 201) {

    print('Succeeeeeeeess change user infos');
    return jsonDecode(response.body) ;
  }
  else {
    throw Exception('Failed to change user infos');
  }
}


// ne fontionne pas sur postman


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





class SearchUsers {



  //// à faiiiire !!!!!!!


}

/*
searchUsers(String username, int limit, int offset) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/users/search?username=$username&limit=$limit&offset=$offset"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    if(response.statusCode == 200) {
      data = jsonDecode(response.body);

    }


    Map<String, dynamic> map = jsonDecode(response.body);


    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapUsers = listResponse[i];
      User user = User.fromJson(mapUsers);
      print(user.username);
      users.add(user);
    }

    print('search users');
    print(jsonDecode(response.body));

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess');
      return users;

    } else {
      throw Exception('Failed to search users');
    }
  }
 */