import 'package:flutter/material.dart';
import 'package:fynder_trial/screens/chat_screen.dart';
import 'package:fynder_trial/screens/home_page.dart';
import 'package:fynder_trial/screens/information_page.dart';
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
        '/': (context) => const HomePage(),
        '/Login': (context) => const MyApp(),
        '/info_page': (context) => const inputinfoPage(),
        '/Sign_Up': (context) => SignUpPage(),
        '/Home_Screen': (context) => SwipeScreen(),
        '/Chat': (context) => ChatScreen(),
        '/NewsSection': (context) => NewsScreen(),
        '/Settings': (context) => SettingsScreen(),
        //This code proves to be redundant since the changing of the routes is
        //done by sign_up.dart file

        //'/Sign_Up': (context) => SignUpPage(),
        //'/HomeScreen': (context) => SwipeScreen(),
        //'/Chat': (context) => ChatScreen(),
        //'/NewsSection': (context) => NewsScreen(),
        //'/Settings': (context) => SettingsScreen(),
      },
    );
  }
}
