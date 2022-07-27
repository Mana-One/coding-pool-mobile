import 'package:coding_pool_v0/models/Author.dart';
import 'package:coding_pool_v0/models/PostData.dart';
import 'package:coding_pool_v0/models/UserStats.dart';
import 'package:coding_pool_v0/services/comment/CommentController.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/views/screens/account/UserAccountScreen.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget(
      {Key? key,
      required this.post,
      required this.commentId,
      required this.user,
      required this.content,
      required this.createdAt})
      : super(key: key);

  final PostData post;
  final String commentId;
  final Author user;
  final String content;
  final String createdAt;

  @override
  State<CommentWidget> createState() => _CommentWidgetState(
      this.post, this.commentId, this.user, this.content, this.createdAt);
}

class _CommentWidgetState extends State<CommentWidget> {
  final PostData post;
  final String commentId;
  final Author user;
  final String content;
  final String createdAt;

  _CommentWidgetState(
      this.post, this.commentId, this.user, this.content, this.createdAt);

  CommentController commentController = CommentController();
  UserController userController = UserController();

  late Future<UserStats> connectedUserInfos;

  @override
  Widget build(BuildContext context) {
    print('comment widget');

    return InkWell(
      child: Card(
        color: Colors.grey[100],
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
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: user.picture != ''
                                    ? Image.network(
                                        user.picture,
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.fill,
                                      ).image
                                    : Image(
                                        alignment: Alignment.center,
                                        image: AssetImage(
                                            'lib/assets/images/bouee.png'),
                                        height: 80,
                                        width: 80,
                                      ).image,
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserAccountScreen(user)));
                            },
                            child: Text(user.username,
                                style: TextStyle(color: Colors.blue[900]))),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 5.0, top: 10.0),
                          child: Text(content)),
                      Container(
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              createdAt.substring(0, 10),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              FutureBuilder(
                  future: _isMe(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return snapshot.data == true
                        ? IconButton(
                            onPressed: () {
                              deleteComment(commentId);
                            },
                            icon: Icon(Icons.delete_outline,
                                color: Colors.deepOrange.shade900))
                        : IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.grey[200],
                            ));
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
    return id == user.id;
  }
}
