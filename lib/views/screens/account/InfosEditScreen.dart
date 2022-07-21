import 'package:coding_pool_v0/services/authentication/AuthenticationController.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:coding_pool_v0/models/Globals.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/views/Home.dart';
import 'package:coding_pool_v0/views/screens/account/AccountScreen.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:image_picker/image_picker.dart';

class InfosEditScreen extends StatefulWidget {
  const InfosEditScreen({Key? key}) : super(key: key);

  @override
  State<InfosEditScreen> createState() => _InfosEditScreenState();
}

class _InfosEditScreenState extends State<InfosEditScreen> {

  UserController userController = UserController();
  AuthenticationController authenticationController = AuthenticationController();

  String _username = '';
  final usernameText = TextEditingController();
  String _email = '';
  final emailText = TextEditingController();

  late Future<void> futureEditPassword;
  late Future<bool> username;
  var futureEditInfos;

  File? image;

  PickedFile? _picture;

  final ImagePicker _picker = ImagePicker();

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

  Future pickImage(ImageSource imageSource) async {
    final image = await _picker.pickImage(source: imageSource);
    if(image == null) return '';

    final imageTemporary = File(image.path);

    print(image.path);

    setState(() {
      this.image = imageTemporary;
      this._picture = PickedFile(image.path);
    } );

  }

  updateInfos() {
    if(_picture != null) {
      userController.changeUserInfos(_username, _email, _picture!.path);
    }
    userController.changeUserInfos(_username, _email, '');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }


  @override
  Widget build(BuildContext context) {
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
                        username = authenticationController.checkUsername(value);
                      }),
                      validator: (value) => username != false ? 'Username already exists, please enter another' : null,
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
                            pickImage(ImageSource.gallery);
                          },
                          child: Text('Pick from gallery', style: TextStyle(color: Colors.white),),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            pickImage(ImageSource.camera);
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
