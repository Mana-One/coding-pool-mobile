import 'package:coding_pool_v0/main.dart';
import 'package:flutter/material.dart';

class EditPasswordWidget extends StatefulWidget {
  const EditPasswordWidget({Key? key}) : super(key: key);

  @override
  State<EditPasswordWidget> createState() => _EditPasswordWidgetState();
}

class _EditPasswordWidgetState extends State<EditPasswordWidget> {
    bool _isSecret = true;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String _oldPassword = '';
    String _newPassword = '';
    String _confirmPassword = '';

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
                    horizontal: 30.0
                ),
                child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),

                      TextFormField(
                        onChanged: (value) => setState(() => _oldPassword = value),
                        validator: (value) => value!.length < 8 ? 'Please Enter a password.\n8 characters minimum required with 1 tiny, 1 uppercase and 1 number' : null,
                        decoration: InputDecoration(
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
                        validator: (value) => value!.length < 8 ? 'Please Enter a password.\n8 characters minimum required with 1 tiny, 1 uppercase and 1 number' : null,
                        decoration: InputDecoration(
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
                        onChanged: (value) => setState(() => _confirmPassword = value),
                          validator: (value) => value!.length < 8 ? 'Please Enter a password.\n8 characters minimum required with 1 tiny, 1 uppercase and 1 number' : null,
                        decoration: InputDecoration(
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
                            //futureEditPassword = changeUserPassword(ChangePassword(oldPassword: _oldPassword, newPassword: _newPassword, confirmPassword: _confirmPassword));

                            if(_newPassword.length < 8 || _newPassword != _confirmPassword) return null;
                              Navigator.pop(context);
                            },
                          child: Text('Save', style: TextStyle(color: Colors.white),)
                      )
                    ]
                ),
              ),
            ),
          ),
        ),
      );
    }
}

