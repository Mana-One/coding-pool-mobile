import 'dart:convert';

import 'package:coding_pool_v0/main.dart';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/viewss/screens/SearchPage.dart';
import 'package:coding_pool_v0/viewss/screens/SearchScreen.dart';
import 'package:coding_pool_v0/viewss/widgets/SearchUserWidget.dart';
import 'package:coding_pool_v0/viewss/widgets/UserStatsWidget.dart';
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

  @override
  Widget build(BuildContext context) {

    return SearchPage();
  }
}































/*import 'dart:convert';

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

  String _user = '';

  TextEditingController _textController = TextEditingController();
  List<dynamic> initialList = [];
  List<dynamic> filteredList = [];


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
        body: Container(
          child: SingleChildScrollView(padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                    children: [TextFormField(
                    onChanged: (value) => {
                    setState(() => _user = value),
                    },
                    decoration: InputDecoration(
                    hintText: 'Search user',
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1.0),
                    borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1.0),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    ),
    ),
    SearchList(_user),
    ]
    ),
          )
        )
        )
    );
  }
}*/

