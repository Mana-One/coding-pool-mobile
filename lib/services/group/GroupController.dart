import 'dart:convert';

import 'package:coding_pool_v0/models/Group.dart';
import 'package:coding_pool_v0/services/group/GroupService.dart';


class GroupController {
  GroupController();
  GroupService groupService = GroupService();

  Future<Group> fetchGroupInfos() async {

    // à corriger après implémentation !!!!!!!!!!!!!!!!
    final response = await groupService.fetchGroupInfos();
    Map<String, dynamic> map = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess fetch connected user infos');
      return Group.fromJson(map);

    } else {
      throw Exception('Failed to fetch own infos');
    }
  }

  Future<Group> fetchGroups() async {

    List<Group> groups = [];

    // à corriger après implémentation !!!!!!!!!!!!!!!!
    final response = await groupService.fetchGroups();
    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      Group group = Group.fromJson(mapPost);
      print(group.name);
      groups.add(group);
    }

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess fetch connected user infos');
      return Group.fromJson(map);

    } else {
      throw Exception('Failed to fetch own infos');
    }
  }
}