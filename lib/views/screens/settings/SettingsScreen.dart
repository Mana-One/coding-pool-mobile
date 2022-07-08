import 'package:coding_pool_v0/views/screens/account/PasswordEditScreen.dart';
import 'package:coding_pool_v0/views/screens/account/UserInfosEditScreen.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:coding_pool_v0/models/Globals.dart' as globals;


import '../authentication/SignInScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool darkmode = false;

  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    globals.token = '';
    prefs.commit();
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {

    bool isSwitched = false;

    print('settings screen');

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white70)),
            child: Text('Sign out', style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.black45),),
            onPressed: () {
              logout();
            }
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Account', style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),),
            tiles: [
              SettingsTile(
                title: Text("Edit account informations", style: TextStyle(color: Colors.blue.shade900)),
                leading: Icon(Icons.account_circle_outlined),
                trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.deepOrange.shade900
                ),
                onPressed: (BuildContext context) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfosEditScreen()));
                },
              ),
              SettingsTile(
                title: Text("Change password", style: TextStyle(color: Colors.blue.shade900)),
                leading: Icon(Icons.password),
                trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.deepOrange.shade900
                ),
                onPressed: (BuildContext context) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordEditScreen()));
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('General', style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),),
            tiles: [
              SettingsTile(
                title: Text('Language', style: TextStyle(color: Colors.blue.shade900)),
                leading: Icon(Icons.language),
                trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.deepOrange.shade900
                ),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: Text('Use System Theme', style: TextStyle(color: Colors.blue.shade900)),
                leading: Icon(Icons.phone_android),
                activeSwitchColor: Colors.deepOrange.shade900,
                onToggle: (value) {
                  setState(() {
                    darkmode = value;
                  });
                },
                initialValue: darkmode,
              ),
            ],
          ),
          /*SettingsSection(
            title: Text('General', style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),),
            tiles: [
              SettingsTile(
                title: Text('F.A.Q'),
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: Text('About'),
                leading: Icon(Icons.phone_android),
                onToggle: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                }, initialValue: isSwitched,
              ),
            ],
          ),*/
        ],
      ),
    );
        /*Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text('Account', style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 200,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white70)),
                      child: Text('Sign out', style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.black45),),
                      onPressed: () {
                        logout();
                      }
                  ),
                ],
              ),
            ),
            Container(
              height: 0.2,
              width: 390,
              color: Colors.grey,
            ),

            SizedBox(
              height: 5,
            ),
            Card(
                margin: const EdgeInsets.all(5.0),
                color: Colors.white70,
                child: ListTile(
                  title: Text("Edit account informations", style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                  leading: Icon(
                      Icons.account_circle,
                      color: Colors.blue.shade900
                  ),
                  trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue.shade900
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfosEditScreen()));
                  },
                )
            ),
            Card(
              margin: const EdgeInsets.all(5.0),
              color: Colors.white70,
              child: ListTile(
                title: Text("Change password", style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                leading: Icon(
                    Icons.lock,
                    color: Colors.blue.shade900
                ),
                trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue.shade900
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordEditScreen()));
                },
              ),
            ),
            /*Card(
                margin: const EdgeInsets.all(5.0),
                color: Colors.white70,
                child: ListTile(
                  title: Text("Edit account informations", style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                  leading: Icon(
                      Icons.account_circle,
                      color: Colors.blue.shade900
                  ),
                  trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue.shade900
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
                  },
                )
            ),*/
            /*Card(
              margin: const EdgeInsets.all(5.0),
              color: Colors.white70,
              child: ListTile(
                title: Text("Change password", style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                leading: Icon(
                    Icons.lock,
                    color: Colors.blue.shade900
                ),
                trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue.shade900
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
                },
              ),
            ),*/
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text('General', style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              height: 0.2,
              width: 390,
              color: Colors.grey,
            ),
            SizedBox(
              height: 5,
            ),
        SettingsList(
          sections: [
            SettingsSection(
              title: Text('Section 1'),
              tiles: [
                SettingsTile(
                  title: Text('Language'),
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: Text('Use System Theme'),
                  leading: Icon(Icons.phone_android),
                  enabled: isSwitched,
                  onToggle: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  }, initialValue: null,
                ),
              ],
            ),
            ]),

            /*Card(
                margin: const EdgeInsets.all(5.0),
                color: Colors.white70,
                child: ListTile(
                  title: Text("Language", style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                  //leading: Icon(Icons.account_circle, color: Colors.blue.shade900),
                  trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue.shade900
                  ),
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
                  },
                )
            ),
            Card(
              margin: const EdgeInsets.all(5.0),
              color: Colors.white70,
              child: ListTile(
                title: Text("Theme", style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                //leading: Icon(Icons.lock, color: Colors.blue.shade900),
                trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue.shade900
                ),
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
                },
              ),
            ),
            Card(
                margin: const EdgeInsets.all(5.0),
                color: Colors.white70,
                child: ListTile(
                  title: Text("About", style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                  //leading: Icon(Icons.account_circle, color: Colors.blue.shade900),
                  trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue.shade900
                  ),
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
                  },
                )
            ),
            Card(
              margin: const EdgeInsets.all(5.0),
              color: Colors.white70,
              child: ListTile(
                title: Text("F.A.Q", style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                //leading: Icon(Icons.lock, color: Colors.blue.shade900),
                trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue.shade900
                ),
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
                },
              ),
            ),*/

          ],
        ),*/

  }
}