import 'package:coding_pool_v0/viewss/guest/SignIn.dart';
import 'package:coding_pool_v0/viewss/guest/SignUp.dart';
import 'package:flutter/material.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}

