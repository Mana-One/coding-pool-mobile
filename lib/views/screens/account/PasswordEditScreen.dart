import 'package:coding_pool_v0/models/ChangePassword.dart';
import 'package:coding_pool_v0/services/user/UserController.dart';
import 'package:coding_pool_v0/viewss/screens/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';


class PasswordEditScreen extends StatefulWidget {
  const PasswordEditScreen({Key? key}) : super(key: key);

  @override
  State<PasswordEditScreen> createState() => _PasswordEditScreenState();
}

class _PasswordEditScreenState extends State<PasswordEditScreen> {

  UserController userController = UserController();

  bool _isSecret1 = true;
  bool _isSecret2 = true;
  bool _isSecret3 = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _oldPassword = '';
  final oldPwdText = TextEditingController();
  String _newPassword = '';
  final newPwdText = TextEditingController();
  String _confirmPassword = '';
  final confirmPwdText = TextEditingController();

  changePassword(ChangePassword changePassword) {
    if(!_formKey.currentState!.validate()) {
      return;
    }
    userController.changeUserPassword(changePassword);
    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
  }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text('Change Password', style: TextStyle(color: Colors.blue.shade900),),
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
                    horizontal: 30.0
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          onChanged: (value) => setState(() => _oldPassword = value),
                          controller: oldPwdText,
                          validator: (value) => value!.length < 8 ? 'Please Enter a password.\n8 characters minimum required with 1 tiny, 1 uppercase and 1 number' : null,
                          obscureText: _isSecret1,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () => setState(() => _isSecret1 = !_isSecret1) ,
                              child: Icon(
                                  ! _isSecret1 ? Icons.visibility : Icons.visibility_off
                              ),
                            ),
                            hintText: 'Enter your old password here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue.shade900),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue.shade900),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value) => setState(() => _newPassword = value),
                          controller: newPwdText,
                          validator: (value) => value!.length < 8 ? 'Please Enter a password.\n8 characters minimum required with 1 tiny, 1 uppercase and 1 number' : null,
                          obscureText: _isSecret2,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () => setState(() => _isSecret2 = !_isSecret2) ,
                              child: Icon(
                                  ! _isSecret2 ? Icons.visibility : Icons.visibility_off
                              ),
                            ),
                            hintText: 'Enter your new password here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue.shade900),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue.shade900),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          onChanged: (value) => setState(() {_confirmPassword = value;}),
                          controller: confirmPwdText,
                          validator: (value) => value!.length < 8 && value == _newPassword ? 'Please Enter a password.\n8 characters minimum required with 1 tiny, 1 uppercase and 1 number' : null,
                          obscureText: _isSecret3,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () => setState(() => _isSecret3 = !_isSecret3) ,
                              child: Icon(
                                  ! _isSecret3 ? Icons.visibility : Icons.visibility_off
                              ),
                            ),
                            hintText: 'Confirm your new password here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue.shade900),
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
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
                            onPressed: () {
                              changePassword(new ChangePassword(oldPassword: _oldPassword, newPassword: _newPassword, confirmPassword: _confirmPassword));
                              oldPwdText.clear();
                              newPwdText.clear();
                              confirmPwdText.clear();
                            },
                            child: Text('Save', style: TextStyle(color: Colors.white),)
                        )
                      ]
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
}

