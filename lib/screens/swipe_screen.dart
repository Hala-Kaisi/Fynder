import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/models/user_profile.dart';
import 'package:fynder/screens/user_list.dart';
import 'package:fynder/services/database.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_drawer.dart';
import 'package:fynder/shared/menu_bottom.dart';
import 'package:provider/provider.dart';

class SwipeScreen extends StatefulWidget {
  final User user;

  const SwipeScreen({required this.user});

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserProfile>>.value(
      value: DatabaseService().users,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title:
          Image.asset('assets/FynderApplicationLogo.png', fit: BoxFit.cover),
          actions: <Widget>[ActionsMenu(user: _currentUser)],
        ),
        bottomNavigationBar: MenuBottom(user: _currentUser),
        drawer: MenuDrawer(user: _currentUser),
        body: UserList(),
      ),
    );
  }
}