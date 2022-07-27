import 'package:coding_pool_v0/views/Sign.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Coding Pool',
      home: Sign(),
      debugShowCheckedModeBanner: false,
    );
  }
}