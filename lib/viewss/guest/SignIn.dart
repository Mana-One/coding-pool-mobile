import 'dart:convert';
import 'dart:io';

import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/services/authentication/AuthenticationController.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/services/user/UserService.dart';
import 'package:coding_pool_v0/viewss/HomeScreen.dart';
import 'package:coding_pool_v0/viewss/guest/SignUp.dart';
import 'package:coding_pool_v0/web/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';


class SignIn extends StatefulWidget {

  SignIn({Key? key,}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  AuthenticationController authenticationController = AuthenticationController();

  bool _isSecret = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';
  String _tokenSignin = '';
  final RegExp emailRegEx = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+") ;

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
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

  signInUser(UserSignIn user) async {

    if(!_formKey.currentState!.validate()) {
      return;
    }

    var response = authenticationController.signIn(user);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    if( token != '') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Wrong email or password"), ));
    }

    setState(() {
      _tokenSignin = prefs.getString('token').toString();
    });
  }

  late var futureSignIn;

  @override
  Widget build(BuildContext context) {
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
                  Image(image: AssetImage('lib/assets/images/login.png'), height: 100, width: 200,),
                  SizedBox(
                    height: 50.0,
                  ),
                  Form(
                    key: _formKey, // clé de validation du formulaire
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          onChanged: (value) => setState(() => _email = value), //on récupère les valeurs
                          validator: (value) => value!.isEmpty || !emailRegEx.hasMatch(value) ? 'Please enter a valid email' : null,
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
                          onChanged: (value) => setState(
                                  () {
                                    _password = value;
                                    //futureSignIn = signInUser(UserSignIn(email: _email, password: _password));
                                  }),
                          validator: (value) => value!.length < 8 ? 'Please Enter a valid password. \n8 characters minimum required with 1 tiny, 1 uppercase \nand 1 number' : null,
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
                          height: 10.0,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          elevation: 0,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          onPressed: () {
                            signInUser(UserSignIn(email: _email, password: _password));
                            if(!emailRegEx.hasMatch(_email)) null;
                            if(_password.length < 8) null;
                            print(_tokenSignin);
                            /*if(_formKey.currentState!.validate() && _tokenSignin != '') {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            }*/
                            /*if (_tokenSignin == ''){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Wrong email or password"), ));
                            }*/
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  /*RichText(
                      text: TextSpan(
                        text: 'Forgot you password? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0
                        ),
                        children: [
                          TextSpan(
                            text: 'Change it here.\n',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic,
                              decorationStyle: TextDecorationStyle.dashed
                            )
                          ),
                        ]
                      ),
                  ),*/
                  Row(
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0
                        ),
                      ),
                      TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));}, child: Text('Register here.'),),
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