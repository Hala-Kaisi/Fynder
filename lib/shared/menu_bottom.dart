// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/screens/chat_list_startups.dart';
import 'package:fynder/screens/chat_startupUser.dart';
import 'package:fynder/screens/news_section.dart';
import 'package:fynder/screens/swipe_screen.dart';

import '../screens/chat_list_investors.dart';

class MenuBottom extends StatefulWidget {
  final User user;

  const MenuBottom({required this.user});

  @override
  _MenuBottomState createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  static int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => SwipeScreen(user: _currentUser)));
          break;
        case 1:
          if(_currentUser.displayName == "startup") {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) => chatListInvestors(user: _currentUser)));
          }
          else{
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) => chatListStartups(user: _currentUser)));
          }
          break;
        case 2:
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => NewsScreen(user: _currentUser)));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      currentIndex: _selectedIndex,
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
      onTap: (value) {
        _onItemTapped(value);
      },
    );
  }
}
