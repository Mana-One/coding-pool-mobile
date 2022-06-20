import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/Models.dart';

///////////////// à tester

class SearchScreenold extends StatefulWidget {
  const SearchScreenold({Key? key}) : super(key: key);

  @override
  State<SearchScreenold> createState() => _SearchScreenoldState();
}

class _SearchScreenoldState extends State<SearchScreenold> {

  TextEditingController _textController = TextEditingController();
  //List<String> initialList = ["Chat", "Chien", "Rat", "Cheval", "Ours"];
  List<User> filteredList = [];

  late final futureUsers;
  List<User> _users = [];

  Future<dynamic> searchUsers(String username, int limit, int offset) async {

    List<User> results = [];

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/users/search?username=$username&limit=$limit&offset=$offset"),
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
      print(user.username);
      results.add(user);
    }

    setState(() {
      _users = results;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {

      return results;

    } else {
      throw Exception('Failed to fetch home timeline');
    }

  }

  //futureUsers = searchUsers('user', 20, 0);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _textController,
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  filteredList = _users
                      .where((element) => element.username.toLowerCase().contains(text))
                      .toList();
                });
              },
            ),
              Expanded(
                child: ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        height: 50,
                        child: Text(_users[index].username),
                      );
                    }),
              ),
          ],
        )
    );
  }
}


/*

Version qui fonctionne bien sans la barre de recherche

import 'dart:convert';

import 'package:coding_pool_v0/main.dart';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/views/screens/SearchScreen.dart';
import 'package:coding_pool_v0/views/widgets/SearchUserWidget.dart';
import 'package:coding_pool_v0/views/widgets/UserStatsWidget.dart';
import 'package:coding_pool_v0/web/UserService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  late final futureUsers;
  List<User> _users = [];

  Future<List<User>> searchUsers(String username, int limit, int offset) async {

    List<User> results = [];

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/users/search?username=$username&limit=$limit&offset=$offset"),
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

    setState(() {
      _users = results;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {

      return results;

    } else {
      throw Exception('Failed to fetch home timeline');
    }

  }

  @override void initState() {
    super.initState();
    futureUsers = searchUsers('user', 20, 0);

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      body: Container(
        child: ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      return SearchUserWidget(_users[index].username.toString());
                    }
                ),
            )
      ),
    );
  }
}


 */