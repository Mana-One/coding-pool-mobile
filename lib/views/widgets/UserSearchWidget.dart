import 'dart:io';

import 'package:coding_pool_v0/models/Author.dart';
import 'package:coding_pool_v0/models/User.dart';
import 'package:coding_pool_v0/views/screens/account/UserAccountScreen.dart';
import 'package:flutter/material.dart';

class UserSearchWidget extends StatefulWidget {
  final User user;
  const UserSearchWidget(this.user);

  @override
  State<UserSearchWidget> createState() => _UserSearchWidgetState(this.user);
}

class _UserSearchWidgetState extends State<UserSearchWidget> {
  User user;
  _UserSearchWidgetState(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccountScreen(Author(username: user.username, id: user.id, picture: user.picture)))),
          title: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Image.network(user.picture,
                    height: 80,
                    width: 80,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Text(user.username, style: TextStyle(fontWeight: FontWeight.w600),),
            ],
          ),
        ),
      ),
    );
  }
}
