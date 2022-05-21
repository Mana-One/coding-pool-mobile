import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:coding_pool_v0/models/Models.dart';
import 'package:coding_pool_v0/views/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'SignIn.dart';

class SignUp extends StatefulWidget {

  const SignUp({Key? key, }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isSecret = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';
  String _username = '';
  final RegExp emailRegEx = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+") ;
  String _isUsernameUsed = 'false';

  Future<String> checkUsername(String username) async {

    String isUsed;

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("https://coding-pool-api.herokuapp.com/accounts/check-username/" + username),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+ token.toString(),
      },
    );

    Map<String, dynamic> map = jsonDecode(response.body);

    isUsed = map['isUsernameUsed'];

    setState(() {
      _isUsernameUsed = isUsed;
    });
    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Succeeeeeeeess');
      return isUsed ;
    }
    else {
      throw Exception('Failed to check username');
    }
  }

  Future<void> signUp(UserSignUp userSignUp) async {
    final response = await http.post(
        Uri.parse("https://coding-pool-api.herokuapp.com/accounts/register"),
        body: { 'email': userSignUp.email, 'username': userSignUp.username, 'password': userSignUp.password}
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success sign up');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }


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
                        onChanged: (value) => setState(() => _username = value),
                        validator: (value) => checkUsername(value!) == 'true' ? 'Username already exists, please enter a new username' : null,
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
                        onChanged: (value) => setState(() => _password = value),
                        validator: (value) => value!.length < 8 ? 'Please Enter a password.\n8 characters minimum required with 1 tiny, 1 uppercase and 1 number' : null,
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

                          signUp(UserSignUp(email: _email, username: _username, password: _password));

                          if(_formKey.currentState!.validate()) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                          }
                          print('heeellloooo new user !!!!!!!!!!');

                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));}, child: Text('Login here.'),),
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


