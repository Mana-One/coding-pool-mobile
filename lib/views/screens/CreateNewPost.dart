import 'package:coding_pool_v0/web/SocialNetworkService.dart';
import 'package:flutter/material.dart';

class CreateNewPost extends StatefulWidget {
  const CreateNewPost({Key? key}) : super(key: key);

  @override
  State<CreateNewPost> createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {

  String _postContent = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new post'),
      ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 350,
              margin: EdgeInsets.only(left: 5.0,bottom: 10.0),
              child: TextFormField(
                onChanged: (value) => setState(() => _postContent = value),
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
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
                  onPressed: () {
                    createPublication(_postContent);
                    Navigator.pop(context);
                  },
                  child: Text('Save', style: TextStyle(color: Colors.white),)
              ),
            )
          ],
        )
    );
  }
}
