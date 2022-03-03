import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/screens/chat_screen.dart';
import 'package:fynder/services/storage.dart';

class matchList_item extends StatefulWidget{
  final User user;

  const matchList_item({required this.user});

  @override
  _matchList_item createState() => _matchList_item();
}

class _matchList_item extends State<matchList_item> {

  late User _matchUser;

  @override
  void initState() {
    _matchUser = widget.user;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Storage storage = Storage();
    // TODO: implement build
    return ListTile(
      //future: Future<String> profileURL = storage.getURL(_currentUser.uid);
      //leading: CircleAvatar(
        //radius: 30,
        //backgroundImage: Image.network(profileURL),
      //),
      title: Text(_matchUser.displayName!, style: TextStyle( //change data from database for all
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }

}