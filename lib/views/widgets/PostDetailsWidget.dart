import 'package:coding_pool_v0/models/Author.dart';
import 'package:coding_pool_v0/models/CommentData.dart';
import 'package:coding_pool_v0/models/PostData.dart';
import 'package:coding_pool_v0/services/comment/CommentController.dart';
import 'package:coding_pool_v0/services/like/LikeController.dart';
import 'package:coding_pool_v0/services/post/PostController.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/views/Home.dart';
import 'package:coding_pool_v0/views/widgets/CommentWidget.dart';
import 'package:coding_pool_v0/views/widgets/PostWidget.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class PostDetailsWidget extends StatefulWidget {
  const PostDetailsWidget(this.createdAt, this.publicationId, this.author,
      this.content, this.nbLikes, this.nbComments, this.isLiked);

  final String publicationId;
  final Author author;
  final String content;
  final int nbLikes;
  final int nbComments;
  final bool isLiked;
  final String createdAt;

  @override
  State<PostDetailsWidget> createState() => _PostDetailsWidgetState(
      this.createdAt,
      this.publicationId,
      this.author,
      this.content,
      this.nbLikes,
      this.nbComments,
      this.isLiked);
}

class _PostDetailsWidgetState extends State<PostDetailsWidget> {
  String publicationId;
  Author author;
  String content;
  String createdAt;
  int nbLikes;
  int nbComments;
  bool isLiked;

  _PostDetailsWidgetState(this.createdAt, this.publicationId, this.author,
      this.content, this.nbLikes, this.nbComments, this.isLiked);

  CommentController commentController = CommentController();
  LikeController likeController = LikeController();
  PostController postController = PostController();
  UserController userController = UserController();

  late Future<List<CommentData>> postComments;

  String _comment = '';
  final fieldText = TextEditingController();

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!");
    return true;
  }

//liquidpulltorefresh
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    postComments = commentController.getPostComments(this.publicationId);
    print('comment details screen');

    return SafeArea(
        child: Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.deepOrange[900],
                              size: 30.0,
                            ),
                          ),
                        ),
                        Text('Reactions', style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold, fontSize: 20),),
                        FutureBuilder(
                            future: _isMe(),
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              return snapshot.data == true
                                  ? IconButton(
                                      onPressed: () {
                                        deletePost(publicationId);
                                      },
                                      icon: Icon(Icons.delete_outline,
                                          color: Colors.deepOrange.shade900))
                                  : IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.grey[50],
                                      ));
                            }),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    PostWidget(createdAt, publicationId, author, content,
                        nbLikes, nbComments, isLiked),
                    this.nbComments > 0 ? Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Comments',
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                    : Container(),
                    Container(
                      //flex: 1,
                      child: FutureBuilder(
                          future: postComments,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<CommentData>> snapshot) {
                            return snapshot.data != null
                                ? ListView(
                                    shrinkWrap: true,
                                    children: [
                                      for (var itemPost
                                          in snapshot.data as List<CommentData>)
                                        CommentWidget(
                                          post: PostData(
                                              id: publicationId,
                                              content: content,
                                              createdAt: createdAt,
                                              author: author,
                                              likes: nbLikes,
                                              comments: nbComments,
                                              isLiked: isLiked),
                                          user: itemPost.leftBy,
                                          content: itemPost.content,
                                          createdAt: itemPost.createdAt,
                                          commentId: itemPost.id,
                                        )
                                    ],
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(
                                      color: Color(3),
                                    ));
                          }),
                    ),
                  ],
                ),
              ),
            )),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 335,
                  margin: EdgeInsets.only(left: 5.0, bottom: 10.0),
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      _comment = value;
                    }),
                    controller: fieldText,
                    minLines: 1,
                    maxLines: 20,
                    decoration: InputDecoration(
                      hintText: 'Add a comment',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.blue.shade900),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () => {
                      setState(() {
                        comment(_comment);
                        postComments = commentController
                            .getPostComments(this.publicationId);
                      }),
                      this.fieldText.clear(),
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget))
                    },
                    icon: Icon(Icons.send),
                    color: Colors.blue[900],
                  ),
                )
              ],
            ))
          ]),
    ));
  }

  like() {
    setState(() {
      if (isLiked) {
        this.isLiked = false;
        likeController.unlikePost(publicationId);
        this.nbLikes--;
      } else {
        this.isLiked = true;
        likeController.likePost(publicationId);
        this.nbLikes++;
      }
    });
  }

  comment(String contentComment) {
    commentController
        .commentPost(this.publicationId, contentComment)
        .whenComplete(() => setState(() {
              postComments =
                  commentController.getPostComments(this.publicationId);
            }));
    nbComments++;
    setState(() {
      _comment = '';
      postComments = commentController.getPostComments(this.publicationId);
    });
  }

  deletePost(String postId) {
    postController.deletePost(postId);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Home()));
  }

  Future<bool> _isMe() async {
    final response = await userController.getConnectedUserStats();
    final id = response.id;
    return id == author.id;
  }
}
