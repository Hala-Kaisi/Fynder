// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fynder_trial/screens/chat_screen.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/Home_Screen');
            break;
          case 1:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatScreen()));
            break;
          case 2:
            Navigator.pushNamed(context, '/NewsSection');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.swipe),
          label: 'Swipe',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: 'NewsSection',
        ),
      ],
    );
  }
}
