import 'package:coding_pool_v0/services/post/PostController.dart';
import 'package:coding_pool_v0/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class PostCreationWidget extends StatefulWidget {
  const PostCreationWidget({Key? key}) : super(key: key);

  @override
  State<PostCreationWidget> createState() => _PostCreationWidgetState();
}

class _PostCreationWidgetState extends State<PostCreationWidget> {
  PostController postController = PostController();

  String _postContent = '';
  final postText = TextEditingController();

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

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  publish() {
    if (_postContent == '') return;
    postController.createPost(_postContent);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add new post'),
          backgroundColor: Colors.blue.shade900,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 350,
              margin: EdgeInsets.only(left: 5.0, bottom: 10.0),
              child: TextFormField(
                onChanged: (value) => setState(() => _postContent = value),
                controller: postText,
                minLines: 1,
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: 'Add a text',
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
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade900),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 15))),
                  onPressed: () {
                    publish();
                    postText.clear();
                  },
                  child: Text(
                    'Publish',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ));
  }
}
