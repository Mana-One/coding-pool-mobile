import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/views/screens/PostDetails.dart';
import 'package:coding_pool_v0/views/screens/UserAccount.dart';
import 'package:http/http.dart' as http;
import 'package:coding_pool_v0/views/MainScreens/Account.dart';
import 'package:coding_pool_v0/web/SocialNetworkService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key,required this.commentId, required this.username, required this.content, required this.createdAt}) : super(key: key);

  final String commentId;
  final String username;
  final String content;
  final String createdAt;

  @override
  State<CommentWidget> createState() => _CommentWidgetState(this.commentId, this.username, this.content, this.createdAt);
}

class _CommentWidgetState extends State<CommentWidget> {

  final String commentId;
  final String username;
  final String content;
  final String createdAt;

  _CommentWidgetState(this.commentId, this.username, this.content, this.createdAt);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: Colors.grey[200],
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.0, top: 5.0),
                    child: Image(
                      alignment: Alignment.center,
                      image: AssetImage('lib/assets/images/bouee.png'),
                      height: 45,
                      width: 45,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: Text(username, style: TextStyle(color: Colors.blue[900]), textAlign: TextAlign.left,),
                    //child: TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));}, child: Text(username),),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 5.0, top: 5.0),
                      width: 300,
                      child: Text(content)
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    width: 300,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(createdAt.substring(0,10), style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  )
                ],
              ),
              IconButton(onPressed: () => deletePostComment(commentId), icon: Icon(Icons.delete_outline))
            ],
          ),
        ),
      ),
    );
  }
}


//////////////////////


///// Old

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({Key? key, required this.username, required this.content, required this.createdAt}) : super(key: key);

  final String username;
  final String content;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Image(
                    alignment: Alignment.center,
                    image: AssetImage('lib/assets/images/bouee.png'),
                    height: 45,
                    width: 45,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(username, style: TextStyle(color: Colors.blue[900]), textAlign: TextAlign.left,),
                  //child: TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));}, child: Text(username),),
                ),
                Container(
                    margin: EdgeInsets.only(right: 5.0, top: 5.0),
                    width: 340,
                    child: Text(content)
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  width: 340,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(createdAt.substring(0,10), style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
