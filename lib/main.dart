import 'package:flutter/material.dart';
import 'package:fynder/screens/chat_screen.dart';
import 'package:fynder/screens/home_page.dart';
import 'package:fynder/screens/news_section.dart';
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
      theme: lightTheme,
      initialRoute: '/',
      home: HomePage(),
    );
  }
}
