import 'package:flutter/material.dart';
import 'package:fynder/screens/chat_screen.dart';
import 'package:fynder/screens/choose_account_type.dart';
import 'package:fynder/screens/home_page.dart';
import 'package:fynder/screens/news_section.dart';
import 'package:fynder/screens/settings_screen.dart';
import 'package:fynder/screens/log_in.dart';
import 'package:fynder/screens/swipe_screen.dart';
import 'package:fynder/textdesign/my_theme.dart';

void main() {
  runApp(Fynder());
}

class Fynder extends StatelessWidget {
  const Fynder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightBlue, inputDecorationTheme: MyTheme().theme()),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/Login': (context) => LogIn(),
        // '/choose_account':(context) => ChooseAccount(),
        '/Swipe': (context) => SwipeScreen(),
        '/Chat': (context) => ChatScreen(),
        '/NewsSection': (context) => NewsScreen(),
        '/Settings': (context) => SettingsScreen(),
      },
    );
  }
}
