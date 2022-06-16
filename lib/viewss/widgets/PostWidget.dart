import 'dart:convert';
import 'dart:io';
import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/viewss/screens/PostDetails.dart';
import 'package:coding_pool_v0/viewss/screens/UserAccount.dart';
import 'package:http/http.dart' as http;
import 'package:coding_pool_v0/viewss/MainScreens/Account.dart';
import 'package:coding_pool_v0/web/SocialNetworkService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostWidget extends StatefulWidget {

  const PostWidget(this.publicationId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);


  final String publicationId;
  final Author author;
  final String content;
  final int nbLikes;
  final int nbComments;
  final bool isLiked;

  @override
  State<PostWidget> createState() => _PostWidgetState(this.publicationId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);
}

class _PostWidgetState extends State<PostWidget> {

  final String publicationId;
  final Author author;
  final String content;
  int nbLikes;
  final int nbComments;
  bool isLiked;

  _PostWidgetState(this.publicationId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetails(publicationId, author, content, nbLikes, nbComments, isLiked)));},
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    height: 80,
                    width: 80,
                  ),
                ),
                Container(
                  width: 110,
                  child: TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(author)));}, child: Text(author.username, style: TextStyle(color: Colors.blue[900],),),),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: 280,
                    child: Text(content)
                ),
                Row(
                  children: [
                    IconButton( onPressed: () => like(),

                    icon: !isLiked ? Icon(Icons.thumb_up_alt_outlined) : Icon(Icons.thumb_up_alt, color: Colors.deepOrange[900],)),

                    Text(nbLikes.toString()),
                    IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetails(publicationId,author,content,nbLikes,nbComments,this.isLiked))), icon: Icon(Icons.insert_comment)),
                    Text(nbComments.toString()),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}







/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class PubWidget extends StatelessWidget {
  const PubWidget({Key? key, required this.publicationId, required this.username, required this.content, required this.nbLikes, required this.nbComments, required this.isLiked}) : super(key: key);

  final String publicationId;
  final String username;
  final String content;
  final int nbLikes;
  final int nbComments;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Image(
                  alignment: Alignment.center,
                  image: AssetImage('lib/assets/images/bouee.png'),
                  height: 80,
                  width: 80,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: TextButton(
                  onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));}, child: Text(username),),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(right: 10.0, top: 10.0),
                  width: 280,
                  child: Text(content)
              ),
              Row(
                children: [
                  IconButton( onPressed: () => {
                      !isLiked ? likePublication(publicationId) : unlikePublication(publicationId)},
                      icon: !isLiked ? Icon(Icons.thumb_up_alt_outlined) : Icon(Icons.thumb_up_alt, color: Colors.blue,)),

                  //else IconButton(onPressed: () =>  {unlikePublication(publicationId), Icon(Icons.thumb_up_alt_outlined)}, icon: Icon(Icons.thumb_up_alt), color: Colors.blue, ),

                  Text(nbLikes.toString()),
                  IconButton(onPressed: () => print(nbComments), icon: Icon(Icons.insert_comment)),
                  Text(nbComments.toString()),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

