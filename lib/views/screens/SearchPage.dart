import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../models/Models.dart';
import '../widgets/SearchUserWidget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();

  var _autoValidate = AutovalidateMode.disabled;
  var _search;

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
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.deepOrange.shade900,),
                        hintText: 'Enter name of user to search',
                        border:  OutlineInputBorder(),
                        filled: true,
                        errorStyle: TextStyle(fontSize: 15.0)
                    ),

                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'Please enter a search term';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _search = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                        onPressed: () {
                          final isValid = _formKey.currentState!.validate();
                          if ( isValid ) {
                            searchUser( _search);
                          }
                          else {
                            setState(() {
                              _autoValidate = AutovalidateMode.always;
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        fillColor: Colors.deepOrange.shade900,
                        child: Padding(
                          padding:  EdgeInsets.all(15.0),
                          child: Text(
                            'Search',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0
                            ),
                          ),
                        )
                    ),
                  ),
                  //_users != null ? Text('Found ${_users.length} users') : Text('No user found'),
                  Container(
                    height: 530,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _users.length,
                        itemBuilder: (context, index) {
                          return SearchUserWidget(_users[index]);
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
