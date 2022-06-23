import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coding_pool_v0/models/Group.dart';


class GroupService {

  Future<http.Response> fetchGroupInfos() async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // à corriger après implémentation !!!!!!!!!!!!!!!!
    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/group/id"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );
    return response;
  }

  Future<http.Response> fetchGroups() async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // à corriger après implémentation !!!!!!!!!!!!!!!!
    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/groups"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );
    return response;
  }
}