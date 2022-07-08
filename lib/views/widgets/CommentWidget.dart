import 'package:coding_pool_v0/models/UserInfos.dart';
import 'package:coding_pool_v0/models/UserStats.dart';
import 'package:coding_pool_v0/services/comment/CommentController.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/viewss/screens/UserAccount.dart';
import 'package:coding_pool_v0/models/Globals.dart' as globals;
import 'package:flutter/material.dart';

import '../../models/Author.dart';


class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key,required this.commentId, required this.username, required this.content, required this.createdAt}) : super(key: key);

  final String commentId;
  final Author username;
  final String content;
  final String createdAt;

  @override
  State<CommentWidget> createState() => _CommentWidgetState(this.commentId, this.username, this.content, this.createdAt);
}

class _CommentWidgetState extends State<CommentWidget> {

  final String commentId;
  final Author username;
  final String content;
  final String createdAt;

  _CommentWidgetState(this.commentId, this.username, this.content, this.createdAt);

  CommentController commentController = CommentController();
  UserController userController = UserController();

  late Future<UserStats> connectedUserInfos;

  @override
  Widget build(BuildContext context) {

    print('comment widget');

    return InkWell(
      child: Card(
        color: Colors.grey[200],
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5.0, top: 5.0),
                        child: Image(
                          alignment: Alignment.center,
                          image: AssetImage('lib/assets/images/bouee.png'),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Container(
                        //child: Text(username.username, style: TextStyle(color: Colors.blue[900]), textAlign: TextAlign.left,),
                        child: TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(username)));}, child: Text(username.username),),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 5.0, top: 10.0),
                          child: Text(content)
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(createdAt.substring(0,10), style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              FutureBuilder(
                  future: _isMe(),
                  builder: (BuildContext context,
                      AsyncSnapshot<bool> snapshot) {
                    return snapshot.data == true
                        ?
                    IconButton(onPressed: () {
                      deleteComment(commentId);
                    },
                        icon: Icon(Icons.delete_outline, color: Colors.deepOrange.shade900)
                    ) : IconButton(onPressed: () {
                      //deleteComment(commentId);
                    },
                        icon: Icon(Icons.delete_outline, color: Colors.grey[200],));
                  })
            ],
          ),
        ),
      ),
    );
  }

  deleteComment(String commentId) {
    commentController.uncommentPost(commentId);
    Navigator.pop(context);
  }

  Future<bool> _isMe() async {
    final response = await userController.getConnectedUserStats();
    final id = response.id;
    print(id);
    return id == username.id;
  }
}