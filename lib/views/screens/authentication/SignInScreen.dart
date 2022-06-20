import 'package:coding_pool_v0/views/screens/home/HomeScreen.dart';
import 'package:coding_pool_v0/viewss/Home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import '../../../models/Models.dart';
import '../../../services/authentication/AuthenticationController.dart';
import 'SignUpScreen.dart';
import 'package:coding_pool_v0/models/Globals.dart' as globals;


class SignInScreen extends StatefulWidget {

  SignInScreen({Key? key,}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  AuthenticationController authenticationController = AuthenticationController();

  bool _isSecret = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _password = '';
  final passwordText = TextEditingController();
  String _email = '';
  final emailText = TextEditingController();

  final RegExp emailRegEx = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+") ;
  final RegExp passwordRegEx1 = RegExp(r"[a-z]");
  final RegExp passwordRegEx2 = RegExp(r"[A-Z]");
  final RegExp passwordRegEx3 = RegExp(r"[0-9]");

  String a = "abcdEFG123";

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
                        onChanged: (value) => setState(() => _email = value),
                        controller: emailText,//on récupère les valeurs
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
                        onChanged: (value) => setState(() { _password = value;}),
                        controller: passwordText,
                        validator: (value) => value!.length < 8 || !value.contains(passwordRegEx1) || !value.contains(passwordRegEx2)|| !value.contains(passwordRegEx3) ? 'Please Enter a valid password. \n8 characters minimum required with 1 tiny, 1 uppercase \nand 1 number' : null,
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
                      FutureBuilder(
                          future: authenticationController.signIn(UserSignIn(email: _email, password: _password)),
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
                                globals.token = snapshot.data!;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                emailText.clear();
                                passwordText.clear();
                              },
                              child: Text(
                                'Sign In',
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
                                if(_formKey.currentState!.validate())
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Wrong email or password"), ));
                              },
                              child: Text(
                                'Sign In',
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
                    TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));}, child: Text('Register here.'),),
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