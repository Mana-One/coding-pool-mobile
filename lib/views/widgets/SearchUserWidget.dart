import 'package:flutter/material.dart';

class SearchUserWidget extends StatefulWidget {
  final String username;
  const SearchUserWidget(this.username);

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState(this.username);
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  String username;
  _SearchUserWidgetState(this.username);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
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
              Text(username, style: TextStyle(fontWeight: FontWeight.w600),),
            ],
          ),
        ),
      ),
    );
  }
}
