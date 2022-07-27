import 'package:coding_pool_v0/models/User.dart';
import 'package:coding_pool_v0/services/search/SearchService.dart';
import 'dart:convert';

class SearchController {
  SearchController();

  SearchService searchService = SearchService();

  Future<List<User>> searchUser(String user) async {
    final response = await searchService.searchUser(user);

    Map<String, dynamic> map = jsonDecode(response.body);
    List<dynamic> listResponse = map['data'];

    List<User> results = [];

    for (int i = 0; i < listResponse.length; i++) {
      Map<String, dynamic> mapUsers = listResponse[i];
      User user = User.fromJson(mapUsers);
      results.add(user);
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('success fetch searched users');
      return results;
    } else {
      throw Exception('Failed to fetch searched users');
    }
  }
}
