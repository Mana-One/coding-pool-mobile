import 'package:coding_pool_v0/models/UserInfos.dart';
import 'package:coding_pool_v0/models/UserStats.dart';
import 'package:coding_pool_v0/services/comment/CommentController.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:flutter/material.dart';


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

  CommentController commentController = CommentController();
  UserController userController = UserController();

  late Future<UserStats> connectedUserInfos;


  deleteComment(String commentId) {
    commentController.uncommentPost(commentId);
  }

  @override
  Widget build(BuildContext context) {

    print('comment widget');

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
                      margin: EdgeInsets.only(left: 5.0, top: 5.0),
                      width: 280,
                      child: Text(content)
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, left: 5.0),
                    width: 280,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(createdAt.substring(0,10), style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  )
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
                        icon: Icon(Icons.delete_outline)
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

  Future<bool> _isMe() async {
    final response = await userController.getConnectedUserStats();
    final name = response.username;
    print(name);
    return name == username;
  }
}