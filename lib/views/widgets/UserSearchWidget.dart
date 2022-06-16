import 'package:flutter/material.dart';
import '../../models/Author.dart';
import '../../models/User.dart';
import '../screens/account/UserAccountScreen.dart';

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
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccountScreen(Author(username: user.username, id: user.id)))),
          title: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Image(
                    alignment: Alignment.center,
                    image: AssetImage('lib/assets/images/bouee.png'),
                    height: 45,
                    width: 45,
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
