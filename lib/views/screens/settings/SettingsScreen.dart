import 'package:coding_pool_v0/models/Globals.dart' as globals;
import 'package:coding_pool_v0/views/screens/account/InfosEditScreen.dart';
import 'package:coding_pool_v0/views/screens/account/PasswordEditScreen.dart';
import 'package:coding_pool_v0/views/screens/authentication/SignInScreen.dart';
import 'package:coding_pool_v0/views/screens/settings/AboutUsScreen.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;

    print('settings screen');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white70)),
            child: Text(
              'Sign out',
              style: TextStyle(
                  fontSize: 15, letterSpacing: 2, color: Colors.black45),
            ),
            onPressed: () {
              logout();
            }),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(
              'Account',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            tiles: [
              SettingsTile(
                title: Text("Edit account informations",
                    style: TextStyle(color: Colors.blue.shade900)),
                leading: Icon(Icons.account_circle_outlined),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: Colors.deepOrange.shade900),
                onPressed: (BuildContext context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfosEditScreen()));
                },
              ),
              SettingsTile(
                title: Text("Change password",
                    style: TextStyle(color: Colors.blue.shade900)),
                leading: Icon(Icons.password),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: Colors.deepOrange.shade900),
                onPressed: (BuildContext context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordEditScreen()));
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(
              'General',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            tiles: [
              SettingsTile(
                title: Text('About Us',
                    style: TextStyle(color: Colors.blue.shade900)),
                leading: Icon(Icons.language),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: Colors.deepOrange.shade900),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUsScreen()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    globals.token = '';
    prefs.commit();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
