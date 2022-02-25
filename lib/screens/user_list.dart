import 'package:flutter/material.dart';
import 'package:fynder/models/user_profile.dart';
import 'package:provider/provider.dart';


class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserProfile>>(context);

    users.forEach((user) {
      print(user.name);
    });

    return Container();
  }
}
