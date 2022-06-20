import 'package:coding_pool_v0/models/User.dart';
import 'package:coding_pool_v0/services/search/SearchController.dart';
import 'package:coding_pool_v0/views/widgets/UserSearchWidget.dart';
import 'package:coding_pool_v0/viewss/widgets/SearchUserWidget.dart';
import 'package:flutter/material.dart';

class SearchUser extends SearchDelegate {

  SearchController searchController = SearchController();

  late Future<List<User>> searchedUsers;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<User>>(
        future: searchController.searchUser(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<User>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return UserSearchWidget(snapshot.data![index]);
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search User'),
    );
  }
}