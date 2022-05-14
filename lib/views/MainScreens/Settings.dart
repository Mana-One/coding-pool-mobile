import 'package:coding_pool_v0/views/screens/EditPasswordWidget.dart';
import 'package:coding_pool_v0/views/screens/EditUserInfosWidget.dart';
import 'package:coding_pool_v0/views/screens/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}



class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return SettingsScreen();
  }
}

