import 'package:coding_pool_v0/models/Author.dart';
import 'package:coding_pool_v0/services/like/LikeController.dart';
import 'package:coding_pool_v0/services/post/PostController.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/views/Home.dart';
import 'package:coding_pool_v0/views/screens/account/UserAccountScreen.dart';
import 'package:coding_pool_v0/views/widgets/PostDetailsWidget.dart';
import 'package:flutter/material.dart';


class PostWidget extends StatefulWidget {

  const PostWidget(this.createdAt, this.postId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);


  final String postId;
  final Author author;
  final String content;
  final int nbLikes;
  final int nbComments;
  final bool isLiked;
  final String createdAt;

  @override
  State<PostWidget> createState() => _PostWidgetState(this.createdAt, this.postId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);
}

class _PostWidgetState extends State<PostWidget> {

  final String postId;
  final String createdAt;
  final Author author;
  final String content;
  int nbLikes;
  final int nbComments;
  bool isLiked;

  LikeController likeController = LikeController();
  PostController postController = PostController();
  UserController userController = UserController();


  _PostWidgetState(this.createdAt, this.postId, this.author, this.content, this.nbLikes, this.nbComments, this.isLiked);

  @override
  Widget build(BuildContext context) {

    double cellContentWidth = MediaQuery.of(context).size.width - 140;

    return Material(
      child: InkWell(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsWidget(postId, author, content, nbLikes, nbComments, isLiked)));},
        child: Container(
          color: Colors.grey.shade200,
          margin: EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.0, top: 15.0, right: 10.0),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(image : author.picture != ''
                            ? Image.network(
                          author.picture,
                          height: 60,
                          width: 60,
                          fit: BoxFit.fill,
                        ).image
                            : Image(
                          alignment: Alignment.center,
                          image: AssetImage('lib/assets/images/bouee.png'),
                          height: 80,
                          width: 80,
                        ).image,
                            fit: BoxFit.fill
                        )
                    ),
                    /*child: author.picture != ''
                        ? Image.network(
                          author.picture,
                          height: 60,
                          width: 60,
                          fit: BoxFit.fill,
                    )
                        : Image(
                            alignment: Alignment.center,
                            image: AssetImage('lib/assets/images/bouee.png'),
                            height: 80,
                            width: 80,
                          ),*/
                  ),
                  Container(
                    width: 80,
                    child: TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccountScreen(author)));}, child: Text(author.username, style: TextStyle(color: Colors.blue[900],),),),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: cellContentWidth,
                          margin: EdgeInsets.only(top: 10.0),
                          child: Text(content)
                      ),
                      FutureBuilder(
                          future: _isMe(),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            return snapshot.data == true
                                ?
                            IconButton(onPressed: () {
                              deletePost(postId);
                            },
                                icon: Icon(Icons.delete_outline, color: Colors.deepOrange.shade900)
                            ) : IconButton(onPressed: () {
                              //deleteComment(commentId);
                            },
                                icon: Icon(Icons.delete_outline, color: Colors.grey[200],));
                          })
                    ],
                  ),

                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5.0, top: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(createdAt.substring(0,10), style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                      ),
                      IconButton( onPressed: () => like(), icon: !isLiked ? Icon(Icons.thumb_up_alt_outlined) : Icon(Icons.thumb_up_alt, color: Colors.deepOrange[900],)),
                      Text(nbLikes.toString()),
                      IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsWidget(postId, author, content, nbLikes, nbComments, isLiked))), icon: Icon(Icons.insert_comment)),
                      Text(nbComments.toString()),
                    ],
                  ),
                ],
              ),
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
        likeController.unlikePost(postId);
        this.nbLikes --;
      }
      else {
        this.isLiked = true;
        likeController.likePost(postId);
        this.nbLikes ++;
      }
    });
  }
  deletePost(String postId) {
    postController.deletePost(postId);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  Future<bool> _isMe() async {
    final response = await userController.getConnectedUserStats();
    final id = response.id;
    return id == author.id;
  }

}
