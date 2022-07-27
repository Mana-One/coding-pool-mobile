import 'package:coding_pool_v0/models/User.dart';
import 'package:coding_pool_v0/services/search/SearchController.dart';
import 'package:coding_pool_v0/views/screens/search/SearchUser.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchController searchController = SearchController();

  late Future<List<User>> searchedUsers;
  final searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search user',
            style: TextStyle(color: Colors.blue.shade900),
          ),
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
          child: Center(child: Container()),
        ),
      ),
    );
  }
}
