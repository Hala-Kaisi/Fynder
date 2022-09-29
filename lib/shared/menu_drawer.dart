// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/screens/investor_profile_screen.dart';
import 'package:fynder/screens/startup_profile_screen.dart';

import '../screens/home_page.dart';

class MenuDrawer extends StatefulWidget {
  final User user;

  const MenuDrawer({required this.user});

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: buildMenuItems(context),
            ),
          ),
          Spacer(),
          Divider(),
           Container(
             child: Align(
               alignment: FractionalOffset.bottomCenter,
               child: Container(
                 child: Column(
                   children: [
                     Divider(),
                     ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => HomePage()));
                        },
                        child: Text("Sign Out"),
                      ),
                   ],
                 ),
               ),
             ),
           ),
        ],
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
                if (_currentUser.displayName == 'startup') {
                  screen = StartupProfileScreen(user: _currentUser);
                }
                if (_currentUser.displayName == 'investor') {
                  screen = InvestorProfileScreen(user: _currentUser);
                }
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
