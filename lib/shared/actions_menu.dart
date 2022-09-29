import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/screens/settings_screen.dart';

class ActionsMenu extends StatefulWidget {
  final User user;

  const ActionsMenu({required this.user});

  @override
  _ActionsMenuState createState() => _ActionsMenuState();
}

class _ActionsMenuState extends State<ActionsMenu> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SettingsScreen(user: _currentUser)));
      },
    );
  }
}
