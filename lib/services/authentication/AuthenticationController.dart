import 'package:flutter/material.dart';

import 'AuthenticationService.dart';

class AuthenticationController with ChangeNotifier {
  AuthenticationController();
  AuthenticationService authenticationService = AuthenticationService();

}