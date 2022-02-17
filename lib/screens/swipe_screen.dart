import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_drawer.dart';
import 'package:fynder/shared/menu_bottom.dart';

class SwipeScreen extends StatelessWidget {
  final User? user;

  const SwipeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Image.asset('assets/FynderApplicationLogo.png', fit: BoxFit.cover),
        actions: <Widget>[ActionsMenu()],
      ),
      bottomNavigationBar: MenuBottom(),
      drawer: MenuDrawer(),
      body: Center(
        child: Text("Swipe Screen"),
      ),
    );
  }
}
