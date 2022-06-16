import 'package:coding_pool_v0/web/UserService.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class EditUserInfosWidget extends StatefulWidget {
  const EditUserInfosWidget({Key? key}) : super(key: key);

  @override
  State<EditUserInfosWidget> createState() => _EditUserInfosWidgetState();
}

class _EditUserInfosWidgetState extends State<EditUserInfosWidget> {

  String _username = '';
  String _email = '';
  String _wallet = '';

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
    changeUserInfos(_username, _wallet, _email);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.blue.shade900,),
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
                    Text('Wallet'),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onChanged: (value) => setState(() {
                        _wallet = value;
                      }),
                      decoration: InputDecoration(
                        hintText: 'Enter your new wallet here',
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
                    ElevatedButton(
                        onPressed: () {
                          updateInfos();
                        },
                        child: Text('Save')
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

/*
Text('Edit Your password : '),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    onChanged: (value) => setState(() => _oldPassword = value),
                    decoration: InputDecoration(
                      hintText: 'Enter your old password here',
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
                  TextFormField(
                    onChanged: (value) => setState(() => _newPassword = value),
                    decoration: InputDecoration(
                      hintText: 'Enter new password here',
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
                  TextFormField(
                    onChanged: (value) => setState(() => _confirmPassword = value),
                    decoration: InputDecoration(
                      hintText: 'Confirm your new password here',
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
                    ElevatedButton(
                        onPressed: () {
                          futureEditPassword = changeUserPassword(ChangePassword(oldPassword: _oldPassword, newPassword: _newPassword, confirmPassword: _confirmPassword));

                          if(_newPassword.length < 8 || _newPassword != _confirmPassword) return null;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserInfosWidget()));
                        },
                        child: Text('Save')
                    )
 */
