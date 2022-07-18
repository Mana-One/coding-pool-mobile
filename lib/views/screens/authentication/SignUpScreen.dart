import 'dart:io';

import 'package:coding_pool_v0/models/SignUp.dart';
import 'package:coding_pool_v0/services/authentication/AuthenticationController.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:coding_pool_v0/models/Globals.dart' as globals;
import 'SignInScreen.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({Key? key, }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  AuthenticationController authenticationController = AuthenticationController();

  late Future<void> signUp;
  late Future<bool> username;

  bool _isSecret = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _password = '';
  final passwordText = TextEditingController();
  String _email = '';
  final emailText = TextEditingController();
  String _username = '';
  final usernameText = TextEditingController();

  final RegExp emailRegEx = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+") ;
  final RegExp passwordRegEx1 = RegExp(r"[a-z]");
  final RegExp passwordRegEx2 = RegExp(r"[A-Z]");
  final RegExp passwordRegEx3 = RegExp(r"[0-9]");

  @override
  Widget build(BuildContext context) {

    print("Sign up screen");

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: 30.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage('lib/assets/images/register.png'), height: 100, width: 200,),

                SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        onChanged: (value) => setState(() => _email = value),
                        controller: emailText,
                        validator: (value) => value!.isEmpty || !emailRegEx.hasMatch(value) ? 'Please enter a valid email.' : null,
                        decoration: InputDecoration(
                          hintText: 'Enter your email here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        onChanged: (value) => setState(() {
                          _username = value;
                          username = authenticationController.checkUsername(value);
                        }) ,
                        validator:(value) => username == true ? 'Username already exists, please enter another' : null,
                        decoration: InputDecoration(
                          hintText: 'Enter your username here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        onChanged: (value) => setState(() {
                          _password = value;
                          authenticationController.signUp(UserSignUp(email: _email, username: _username, password: _password, picture: File('')));
                        }),
                        controller: passwordText,
                        validator: (value) => value!.length < 8 || !value.contains(passwordRegEx1) || !value.contains(passwordRegEx2) || !value.contains(passwordRegEx3) ? 'Please Enter a valid password. \n8 characters minimum required with at least: \n - a lowercase. \n - an uppercase. \n - a number.' : null,
                        obscureText: _isSecret,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () => setState(() => _isSecret = !_isSecret) ,
                            child: Icon(
                                ! _isSecret ? Icons.visibility : Icons.visibility_off
                            ),
                          ),
                          hintText: 'Enter your password here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FutureBuilder(
                          future: authenticationController.signUp(UserSignUp(email: _email, username: _username, password: _password, picture: File(''))),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            return snapshot.data != null
                                ? RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              elevation: 0,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                                usernameText.clear();
                                emailText.clear();
                                passwordText.clear();
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                                : RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              elevation: 0,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              onPressed: () {
                                if(_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Please retry"), ));
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0
                      ),
                    ),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));}, child: Text('Login here.'),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}