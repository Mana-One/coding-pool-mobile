import 'package:coding_pool_v0/models/PostData.dart';
import 'package:coding_pool_v0/views/Sign.dart';
import 'package:coding_pool_v0/views/widgets/PostWidget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'dart:io';

class HomeHome extends StatefulWidget {
  const HomeHome({Key? key}) : super(key: key);

  @override
  State<HomeHome> createState() => _HomeHomeState();
}

class _HomeHomeState extends State<HomeHome> {

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
        ),
        dark: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange,
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Coding Pool',
          home: Sign(),
        ));
  }
}
