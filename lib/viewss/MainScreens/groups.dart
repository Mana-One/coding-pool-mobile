import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/viewss/widgets/PostWidget.dart';
import 'package:coding_pool_v0/web/UserService.dart';
import 'package:flutter/material.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {

  late Future<List<User>> futureUsersSearch;

  List<User> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //futureUsersSearch = searchUsers('user', 20, 0);
   // users = futureUsersSearch as List<User>;

  }

  @override
  Widget build(BuildContext context) {
    return Container(

      /*margin: new EdgeInsets.only(right: 10, left: 15),
      child: ElevatedButton(
        onPressed: () {
          for(var v in users) {
            print(v.username);
          }
        },
        child: Row(
          children: [
            Text('Logout'),
            Icon(Icons.logout, size: 20,),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.deepOrange[900],
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),

      ),*/
    );
  }
}
