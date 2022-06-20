import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Author.dart';
import 'package:coding_pool_v0/services/comment/CommentController.dart';
import 'package:coding_pool_v0/services/like/LikeController.dart';
import 'package:coding_pool_v0/views/screens/account/UserAccountScreen.dart';
import 'package:coding_pool_v0/viewss/screens/UserAccount.dart';
import 'package:coding_pool_v0/viewss/widgets/CommentWidget.dart';
import 'package:coding_pool_v0/web/SocialNetworkService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:coding_pool_v0/models/Globals.dart' as globals;
import '../../models/CommentData.dart';
import '../widgets/CommentWidget.dart';

class PostDetailsWidget extends StatefulWidget {
  const PostDetailsWidget(this.publicationId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);

  final String publicationId;
  final Author author;
  final String content;
  final int nbLikes;
  final int nbComments;
  final bool isLiked;

  @override
  State<PostDetailsWidget> createState() => _PostDetailsWidgetState(this.publicationId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);
}

class _PostDetailsWidgetState extends State<PostDetailsWidget> {


  String publicationId;
  Author author;
  String content;
  int nbLikes;
  int nbComments;
  bool isLiked;

  _PostDetailsWidgetState(this.publicationId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);

  CommentController commentController = CommentController();
  LikeController likeController = LikeController();

  late Future<List<CommentData>> postComments;

  String _comment = '';
  final fieldText = TextEditingController();

  like() {
    setState(() {
      if( isLiked ) {
        this.isLiked = false;
        likeController.unlikePost(publicationId);
        this.nbLikes --;
      }
      else {
        this.isLiked = true;
        likeController.likePost(publicationId);
        this.nbLikes ++;
      }
    });
  }

  comment(String contentComment) {
    commentController.commentPost(this.publicationId, contentComment);
    nbComments++;
    setState(() => _comment = '');
    //Navigator.pop(context);
    //Navigator.push(context,MaterialPageRoute(builder:(context) => PostDetailsWidget(publicationId, author, content, nbLikes, nbComments, isLiked)));
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!");
    return true;
  }

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
              children : [
                Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.arrow_back_ios, color: Colors.deepOrange[900], size: 30.0,),
                                            ),
                                          ),
                                          SizedBox(width: 120,),
                                          TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccountScreen(author)));}, child: Text(author.username, style: TextStyle(color: Colors.blue[900], fontSize: 25),),),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        child: Text(content, style: TextStyle(fontSize: 18),),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          IconButton( onPressed: () => like(), icon: !isLiked ? Icon(Icons.thumb_up_alt_outlined) : Icon(Icons.thumb_up_alt, color: Colors.deepOrange[900],)),
                                          Text(nbLikes.toString()),
                                          Container(child: Icon(Icons.insert_comment),),
                                          Text(nbComments.toString()),
                                        ],
                                      ),
                                    ]
                                )
                            ),
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
                                          for( var itemPost in snapshot.data as List<CommentData>)
                                            CommentWidget(username: itemPost.leftBy.username, content: itemPost.content, createdAt: itemPost.createdAt, commentId: itemPost.id,)
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
                    )
                ),

                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 335,
                          margin: EdgeInsets.only(left: 5.0,bottom: 10.0),
                          child: TextFormField(
                            onChanged: (value) => setState(() => _comment = value),
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
                              comment(_comment),
                              this.fieldText.clear()
                              //_commentsData.add(CommentsData(id: _comment., content: _comment, createdAt: createdAt, leftBy: leftBy)),
                            },
                            icon: Icon(Icons.send), color: Colors.blue[900],),
                        )

                      ],
                    )
                )
              ]
          ),
        )
    );
  }
}

final String assetName = 'lib/assets/images/logo_no_text.svg';
final Widget svgLogoNoText = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo',
  height: 50,
  width: 100,
);

/*

FutureBuilder(
        future: _futurePost,
        builder: (BuildContext context,
            AsyncSnapshot<List<CommentData>> snapshot) {
          return snapshot.data != null
              ? ListView(
            children: [
              for (CommentData comment
              in snapshot.data as List<CommentData>)
                comment
            ],
          )
              : Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Color(50),
              ));
        });

SafeArea(
        child: Scaffold(
          body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
            Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.arrow_back_ios, color: Colors.deepOrange[900], size: 30.0,),
                                        ),
                                      ),
                                      SizedBox(width: 120,),
                                      TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(author)));}, child: Text(author.username, style: TextStyle(color: Colors.blue[900], fontSize: 25),),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    child: Text(content, style: TextStyle(fontSize: 18),),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      IconButton( onPressed: () => like(), icon: !isLiked ? Icon(Icons.thumb_up_alt_outlined) : Icon(Icons.thumb_up_alt, color: Colors.deepOrange[900],)),
                                      Text(nbLikes.toString()),
                                      Container(child: Icon(Icons.insert_comment),),
                                      //IconButton(onPressed: () => print('nbComments'), icon: Icon(Icons.insert_comment)),
                                      Text(nbComments.toString()),
                                    ],
                                  ),
                                ]
                            )
                        ),
                        Container(
                          //flex: 1,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                for( var itemPost in futurePost)
                                  CommentWidget(commentId: itemPost.id,username: itemPost.leftBy.username, content: itemPost.content, createdAt: itemPost.createdAt,)
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                )
            ),

            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 335,
                      margin: EdgeInsets.only(left: 5.0,bottom: 10.0),
                      child: TextFormField(
                        onChanged: (value) => setState(() => _comment = value),
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
                          comment(_comment),
                          _comment = '',
                          //_commentsData.add(CommentsData(id: _comment., content: _comment, createdAt: createdAt, leftBy: leftBy)),
                        },
                        icon: Icon(Icons.send), color: Colors.blue[900],),
                    )

                  ],
                )
            )
          ]
      ),
        )
    )
 */

