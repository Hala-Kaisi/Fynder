// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fynder/screens/profile_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = ["Profile"];

    List<Widget> menuItems = [];
    menuItems.add(
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          image: DecorationImage(
              image: AssetImage('assets/FynderApplicationLogo.png'),
              fit: BoxFit.contain),
        ),
        child: null,
      ),
    );

    menuTitles.forEach((String element) {
      Widget screen = Container();
      menuItems.add(ListTile(
          title: Text(
            element,
            style: TextStyle(fontSize: 18),
          ),
          onTap: () {
            switch (element) {
              case 'Profile':
                screen = ProfileScreen();
                break;
            }
            Navigator.of(context).pop(); // removes the drawer from the stack
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screen));
          }));
    });

    return menuItems;
  }
}
