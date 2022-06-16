import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Models.dart';

Future<String> signIn(UserSignIn user) async {
  print("server call");
  final response = await http.post(
      Uri.parse("https://coding-pool-api.herokuapp.com/auth/login"),
      body: { 'email': user.email, 'password': user.password}
  );
  Map<String, dynamic> map = jsonDecode(response.body);

  final prefs = await SharedPreferences.getInstance();
  prefs.setString('token', map['access_token']);

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('success ----');
    return "OK";
  } else {
    return "KO";
  }
}

Future<void> signUp(UserSignUp userSignUp) async {
  final response = await http.post(
      Uri.parse("https://coding-pool-api.herokuapp.com/accounts/register"),
      body: { 'email': userSignUp.email, 'username': userSignUp.username, 'password': userSignUp.password}
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Success sign up');
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to sign up');
  }
}

signInUser(UserSignIn user) {

  /*if(!_formKey.currentState!.validate()){
    return;
  }*/
  // Valider les emails et mots de passes :
  // Si non valide afficher erreur et arreter le traitement
  //if(!emailRegEx.hasMatch(_email)) null;
  //if(_password.length < 8) null;
  ////// FIN BLOCK DE VALIDATION EMAIL ET MOT DE PASSE


  var response = signIn(user);
  /* if(response=="OK"){
      // success : preparer la navigation + navigation
      _email = "";
      _password = "";
      // En suite tu navigues :
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      print("eeeeerrrreur");
      // failure : afficher le message d erreur
    }*/

  //final prefs = SharedPreferences.getInstance();


  /*late var v;

    prefs.then((value) => setState(() {
      v = value.getString('token');
      _tokenSignin = v;
    })
    ).catchError((e)=>print("error :"+e));*/

  //setState(() => value.getString('token')));


  //setState(() {
  //  _tokenSignin = prefs.then((value) => {print("value", value); return "test token";})
  //getString('token').toString();
  //});


  //print(_tokenSignin);
  //if (_tokenSignin == ''){
  //ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Wrong email or password"), ));
  //}

}