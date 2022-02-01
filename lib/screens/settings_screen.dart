// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_bottom.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Image.asset('assets/FynderApplicationLogo.png', fit: BoxFit.cover),
        actions: <Widget>[ActionsMenu()],
      ),
      bottomNavigationBar: MenuBottom(),
      body: Center(
        child: Text("Settings Screen"),
      ),
    );
  }
}
