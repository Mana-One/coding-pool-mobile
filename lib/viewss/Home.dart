import 'package:coding_pool_v0/views/screens/account/AccountScreen.dart';
import 'package:coding_pool_v0/views/screens/groups/GroupsScreen.dart';
import 'package:coding_pool_v0/views/screens/home/HomeScreen.dart';
import 'package:coding_pool_v0/views/screens/settings/SettingsScreen.dart';
import 'package:coding_pool_v0/viewss/MainScreens/Account.dart';
import 'package:coding_pool_v0/viewss/MainScreens/Home.dart';
import 'package:coding_pool_v0/viewss/MainScreens/Search.dart';
import 'package:coding_pool_v0/viewss/MainScreens/Settings.dart';
import 'package:coding_pool_v0/viewss/MainScreens/groups.dart';
import 'package:coding_pool_v0/viewss/screens/PostDetails.dart';
import 'package:coding_pool_v0/viewss/screens/SearchPage.dart';
import 'package:coding_pool_v0/viewss/screens/SearchScreen.dart';
import 'package:coding_pool_v0/viewss/screens/SettingsScreen.dart';
import 'package:coding_pool_v0/viewss/screens/UserAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Search(),
    GroupsScreen(),
    AccountScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: svgLogoText,
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.deepOrange.shade900,
        selectedItemColor: Colors.blue[900],
        selectedLabelStyle: optionStyle,
        onTap: _onItemTapped,
      ),
    );
  }
}

final String assetName = 'lib/assets/images/logo_text_black.svg';
final Widget svgLogoText = SvgPicture.asset(
    assetName,
    semanticsLabel: 'Acme Logo',
  height: 50,
  width: 100,
);
