import 'dart:convert';
import 'dart:io';

import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/views/HomeScreen.dart';
import 'package:coding_pool_v0/views/guest/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {

  SignIn({Key? key,}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isSecret = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';
  String _tokenSignin = '';
  final RegExp emailRegEx = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+") ;


  Future<String> signIn(UserSignIn user) async {
    final response = await http.post(
      Uri.parse("https://coding-pool-api.herokuapp.com/auth/login"),
      body: { 'email': user.email, 'password': user.password}
    );
    Map<String, dynamic> map = jsonDecode(response.body);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', map['access_token']);

    print(prefs.getString('token'));

    setState(() {
      _tokenSignin = prefs.getString('token').toString();
    });


    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success Login');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign in');
    }
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
                                    futureSignIn = signIn(UserSignIn(email: _email, password: _password));
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
                            if(!emailRegEx.hasMatch(_email)) null;
                            if(_password.length < 8) null;
                            print(_tokenSignin);
                            if(_formKey.currentState!.validate() && futureSignIn != '' && _tokenSignin != '') {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Wrong email or password"), ));
                            }
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