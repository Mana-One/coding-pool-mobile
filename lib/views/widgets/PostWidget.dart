import 'package:coding_pool_v0/models/Author.dart';
import 'package:coding_pool_v0/services/like/LikeController.dart';
import 'package:coding_pool_v0/services/like/LikeService.dart';
import 'package:coding_pool_v0/views/screens/account/UserAccountScreen.dart';
import 'package:coding_pool_v0/views/widgets/PostDetailsWidget.dart';
import 'package:flutter/material.dart';

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

  LikeController likeController = LikeController();

  final String publicationId;
  final Author author;
  final String content;
  int nbLikes;
  final int nbComments;
  bool isLiked;

  _PostWidgetState(this.publicationId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsWidget(publicationId, author, content, nbLikes, nbComments, isLiked)));},
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
                    child: TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccountScreen(author)));}, child: Text(author.username, style: TextStyle(color: Colors.blue[900],),),),
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
                      IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsWidget(publicationId, author, content, nbLikes, nbComments, isLiked))), icon: Icon(Icons.insert_comment)),
                      Text(nbComments.toString()),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

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

}
