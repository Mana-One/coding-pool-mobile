import 'dart:io';

import 'package:coding_pool_v0/models/Globals.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/views/Home.dart';
import 'package:coding_pool_v0/views/screens/account/AccountScreen.dart';
import 'package:coding_pool_v0/views/screens/account/ImageFromGalleryScreen.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:image_picker/image_picker.dart';

class UserInfosEditScreen extends StatefulWidget {
  const UserInfosEditScreen(this._picture);
  final _picture;

  @override
  State<UserInfosEditScreen> createState() => _UserInfosEditScreenState(this._picture);
}

class _UserInfosEditScreenState extends State<UserInfosEditScreen> {
  _UserInfosEditScreenState(this._picture);
  final _picture;

  UserController userController = UserController();

  String _username = '';
  final usernameText = TextEditingController();
  String _email = '';
  final emailText = TextEditingController();

  late Future<void> futureEditPassword;
  var futureEditInfos;

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

  updateInfos() {
    userController.changeUserInfos(_username, _email, _picture);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryScreen(type)));
  }


  @override
  Widget build(BuildContext context) {

    print('picture : ' + _picture.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text('Edit Account Informations', style: TextStyle(color: Colors.blue.shade900),),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.deepOrange.shade900,),
            onPressed: () { Navigator.pop(context); }
        ),
      ),
      body: Container(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.0
              ),
              child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text('Username : '),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onChanged: (value) => setState(() {
                        _username = value;
                        //futureEditInfos = changeUserInfos(_username, _wallet, _email);
                      }),
                      controller: usernameText,
                      decoration: InputDecoration(
                        hintText: 'Enter your new username here',
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
                    SizedBox(
                      height: 5,
                    ),
                    Text('Email : '),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onChanged: (value) => setState(() {
                        _email = value;
                        //futureEditInfos = changeUserInfos(_username, _wallet, _email);
                      }),
                      controller: emailText,
                      decoration: InputDecoration(
                        hintText: 'Enter your email here',
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
                    SizedBox(
                      height: 5,
                    ),
                    Text('Picture'),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _handleURLButtonPress(context, ImageSourceType.gallery);
                          },
                          child: Text('Pick from gallery', style: TextStyle(color: Colors.white),),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _handleURLButtonPress(context, ImageSourceType.camera);
                          },
                          child: Text('Pick from camera', style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          updateInfos();
                          usernameText.clear();
                          emailText.clear();
                        },
                        child: Text('Save', style: TextStyle(color: Colors.white),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}