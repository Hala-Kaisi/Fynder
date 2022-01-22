import 'package:flutter/material.dart';
import 'package:fynder_trial/shared/actions_menu.dart';
import 'package:fynder_trial/shared/menu_bottom.dart';
import 'package:fynder_trial/shared/menu_drawer.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

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
        child: Text("News Section"),
      ),
    );
  }
}
