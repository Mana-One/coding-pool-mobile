import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/views/MainScreens/Account.dart';
import 'package:coding_pool_v0/views/screens/UserAccount.dart';
import 'package:coding_pool_v0/views/widgets/CommentWidget.dart';
import 'package:coding_pool_v0/views/widgets/PostWidget.dart';
import 'package:coding_pool_v0/web/SocialNetworkService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class PostDetails extends StatefulWidget {
  const PostDetails(this.publicationId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);

  final String publicationId;
  final Author author;
  final String content;
  final int nbLikes;
  final int nbComments;
  final bool isLiked;

  @override
  State<PostDetails> createState() => _PostDetailsState(this.publicationId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);
}

class _PostDetailsState extends State<PostDetails> {

   String publicationId;
   Author author;
   String content;
   int nbLikes;
   int nbComments;
   bool isLiked;

  _PostDetailsState(this.publicationId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);

  late final futurePost;

  List<CommentsData> _commentsData = [];

  Future<Comment> getPublicationComments(String publicationId) async {
    List<CommentsData> comments = [];

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/comments?limit=20&offset=0&publicationId=" + publicationId),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    print(jsonDecode(response.body));

    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> listResponse = map['data'] ;

    for(int i=0; i<listResponse.length; i++) {
      Map<String, dynamic> mapPost = listResponse[i];
      CommentsData comment = CommentsData.fromJson(mapPost);
      print(comment.content);
      comments.add(comment);
    }

    setState(() {
      _commentsData = comments;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeesssssss  ');
      return jsonDecode(response.body) ;

    } else {
      throw Exception('Failed to fetch own timeline');
    }
  }

  like() {
    setState(() {
      if( isLiked ) {
        this.isLiked = false;
        unlikePublication(publicationId);
        this.nbLikes --;
      }
      else {
        this.isLiked = true;
        likePublication(publicationId);
        this.nbLikes ++;
      }
    });
  }

   String _comment = '';

  @override
  void initState() {
    super.initState();
    futurePost =  getPublicationComments(this.publicationId);
    //print(futurePost.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(author)));}, child: Text(author.username, style: TextStyle(color: Colors.blue[900],),),),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      child: Text(content),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        //if (!isLiked) IconButton(onPressed: () => print(nbLikes), icon: Icon(Icons.thumb_up_alt_outlined)) else IconButton(onPressed: () => print(nbLikes), icon: Icon(Icons.thumb_up_alt), color: Colors.blue,),
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
                                  for( var itemPost in _commentsData)
                                    CommentWidget(username: itemPost.leftBy.username, content: itemPost.content, createdAt: itemPost.createdAt,)
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
                    width: 350,
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
                    margin: EdgeInsets.only(right: 3.0, left: 5.0),
                    child: IconButton(
                      onPressed: () => {
                        commentPublication(publicationId, _comment),
                        Navigator.push(context,MaterialPageRoute(builder:(context) => PostDetails(publicationId, author, content, nbLikes, nbComments+1, isLiked)))
                      },
                      icon: Icon(Icons.send), color: Colors.blue[900],),
                  )

                ],
              )
              )
            ]
        ),
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

