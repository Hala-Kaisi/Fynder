import 'package:flutter/material.dart';
import 'package:fynder/screens/chat_screen.dart';
import 'package:fynder/screens/home_page.dart';
import 'package:fynder/screens/information_page.dart';
import 'package:fynder/screens/news_section.dart';
import 'package:fynder/screens/settings_screen.dart';
import 'package:fynder/screens/sign_up.dart';
import 'package:fynder/screens/swipe_screen.dart';

void main() {
  runApp(Fynder());
}

class Fynder extends StatelessWidget {
  const Fynder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/Login': (context) => const MyApp(),
        '/info_page': (context) => const inputinfoPage(),
        '/Sign_Up': (context) => SignUpPage(),
        '/Home_Screen': (context) => SwipeScreen(),
        '/Chat': (context) => ChatScreen(),
        '/NewsSection': (context) => NewsScreen(),
        '/Settings': (context) => SettingsScreen(),
      },
    );
  }
}
