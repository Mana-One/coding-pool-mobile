import 'package:coding_pool_v0/views/guest/SignIn.dart';
import 'package:coding_pool_v0/views/screens/EditPasswordWidget.dart';
import 'package:coding_pool_v0/views/screens/EditUserInfosWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    prefs.commit();
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  width: 180,
                ),
                OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserInfosWidget()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
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

            Card(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordWidget()));
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}


/*

Container(
              height: 100,
              width: 400,
              child: Card(
                color: Colors.blue.shade900,
                child: Column(
                    children: [
                      Row(
                        children: [
                          Card(
                            color: Colors.white,
                            child: Text('Username : ', style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                          ),
                          Card(
                              color: Colors.white,
                              child: Text('Username : ', style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Card(
                              color: Colors.white,
                              child: Text('Username : ', style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                          ),
                          Card(
                              color: Colors.white,
                              child: Text('Username : ', style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Card(
                              color: Colors.white,
                              child: Text('Username : ', style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                          ),
                          Card(
                              color: Colors.white,
                              child: Text('Username : ', style: TextStyle(color: Colors.blue.shade900,fontSize: 15, fontWeight: FontWeight.w500),),
                          )
                        ],
                      ),
                    ]
                ),
              ),
            ),

 */