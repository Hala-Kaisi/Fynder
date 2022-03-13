import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/screens/chat_startupUser.dart';
import 'package:fynder/services/storage.dart';

class matchList_item extends StatefulWidget{
  final String matchName;

  const matchList_item({required this.matchName});

  @override
  _matchList_item createState() => _matchList_item();
}

class _matchList_item extends State<matchList_item> {

  late String _matchName;

  @override
  void initState() {
    _matchName = widget.matchName;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Storage storage = Storage();
    // TODO: implement build
    return ListTile(
      trailing: const Icon(Icons.chat),
      //future: Future<String> profileURL = storage.getURL(_currentUser.uid);
      //leading: CircleAvatar(
        //radius: 30,
        //backgroundImage: Image.network(profileURL),
      //),
      title: Text(_matchName, style: const TextStyle( //change data from database for all
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blue
      ),
      ),
    );
  }

}