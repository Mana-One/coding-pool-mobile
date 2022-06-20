import 'dart:convert';

import 'package:coding_pool_v0/views/main.dart';
import 'package:coding_pool_v0/models/User.dart';
import 'package:coding_pool_v0/viewss/screens/SearchScreen.dart';
import 'package:coding_pool_v0/viewss/widgets/SearchUserWidget.dart';
import 'package:coding_pool_v0/viewss/widgets/UserStatsWidget.dart';
import 'package:coding_pool_v0/web/UserService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SearchList extends StatefulWidget {
  const SearchList(this.usernameSearched);
  final String usernameSearched;

  @override
  State<SearchList> createState() => _SearchListState(this.usernameSearched);
}

class _SearchListState extends State<SearchList> {

  final String usernameSearched;
  _SearchListState(this.usernameSearched);

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

  @override void initState() {
    super.initState();
    futureUsers = searchUsers(this.usernameSearched, 20, 0);

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(

        body: Container(
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
              itemCount: _users.length,
              itemBuilder: (context, index) {
                print(_users[index].username);
                return SearchUserWidget(_users[index]);
              }
          ),
        )
    ),
    );
  }
}

/*
import 'dart:convert';

import 'package:coding_pool_v0/main.dart';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/views/screens/SearchList.dart';
import 'package:coding_pool_v0/views/screens/SearchScreen.dart';
import 'package:coding_pool_v0/views/widgets/SearchUserWidget.dart';
import 'package:coding_pool_v0/views/widgets/UserStatsWidget.dart';
import 'package:coding_pool_v0/web/UserService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Search extends StatefulWidget {
  const Search();

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _textController = TextEditingController();
  List<dynamic> initialList = [];
  List<dynamic> filteredList = [];


  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      body: Container(
        child: TextField(
          controller: _textController,
          onChanged: (text) {
            text = text.toLowerCase();
            SearchList(text);
          },
        ),
            )
      ),
    );
  }
}

 */