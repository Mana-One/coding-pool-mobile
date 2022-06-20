import 'package:coding_pool_v0/services/search/SearchController.dart';
import 'package:coding_pool_v0/views/screens/search/SearchUser.dart';
import 'package:coding_pool_v0/views/widgets/UserSearchWidget.dart';
import 'package:coding_pool_v0/viewss/widgets/SearchUserWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import '../../../models/User.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  SearchController searchController = SearchController();

  late Future<List<User>> searchedUsers;

  final _formKey = GlobalKey<FormState>();

  var _autoValidate = AutovalidateMode.disabled;
  var _search;

  final searchText = TextEditingController();

  List<User> _users = [];


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

    setState(() {
      _users = results;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch home timeline');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search user', style: TextStyle(color: Colors.blue.shade900),),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              color: Colors.deepOrange.shade900,
              onPressed: () {
                showSearch(context: context, delegate: SearchUser());
              },
              icon: Icon(Icons.search_sharp),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container()
          ),
        ),
      ),
    );
  }
}
