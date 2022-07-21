import 'package:coding_pool_v0/viewss/HomeScreen.dart';
import 'package:coding_pool_v0/viewss/Sign.dart';

import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coding Pool',
      home: Sign(),
    );
  }
}
