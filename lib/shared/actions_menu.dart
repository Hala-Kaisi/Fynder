import 'package:flutter/material.dart';
import 'package:fynder/screens/settings_screen.dart';

class ActionsMenu extends StatelessWidget {
  const ActionsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()));
      },
    );
  }
}
