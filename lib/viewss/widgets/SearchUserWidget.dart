import 'package:coding_pool_v0/models/Author.dart';
import 'package:coding_pool_v0/models/User.dart';
import 'package:coding_pool_v0/viewss/screens/UserAccount.dart';
import 'package:flutter/material.dart';

class SearchUserWidget extends StatefulWidget {
  final User user;
  const SearchUserWidget(this.user);

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState(this.user);
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  User user;
  _SearchUserWidgetState(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(Author(username: user.username, id: user.id, picture: '')))),
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
