import 'package:flutter/material.dart';
import 'package:fynder_trial/screens/chat_screen.dart';
import 'package:fynder_trial/screens/news_section.dart';
import 'package:fynder_trial/screens/settings_screen.dart';
import 'package:fynder_trial/screens/sign_up.dart';
import 'package:fynder_trial/screens/swipe_screen.dart';

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
        '/': (context) => MyApp(),
        '/Sign_Up': (context) => SignUpPage(),
        '/HomeScreen': (context) => SwipeScreen(),
        '/Chat': (context) => ChatScreen(),
        '/NewsSection': (context) => NewsScreen(),
        '/Settings': (context) => SettingsScreen(),
      },
    );
  }
}
