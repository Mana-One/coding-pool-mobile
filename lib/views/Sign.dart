import 'package:coding_pool_v0/views/guest/SignIn.dart';
import 'package:coding_pool_v0/views/guest/SignUp.dart';
import 'package:flutter/material.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  List<Widget> _widgetsSign = [];
  int _indexSelected = 0;

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}

