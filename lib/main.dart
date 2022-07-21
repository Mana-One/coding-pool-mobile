import 'package:coding_pool_v0/HomeDark.dart';
import 'package:coding_pool_v0/views/Home.dart';
import 'package:coding_pool_v0/views/Sign.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
            debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // French, no country code
      ],
            title: 'Coding Pool',
            home: Sign(),
          );
  }
}

/*
MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coding Pool',
      home: Sign(),
    );
 */