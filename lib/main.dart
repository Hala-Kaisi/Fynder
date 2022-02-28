import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fynder/screens/home_page.dart';
import 'package:fynder/textdesign/my_theme.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
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
