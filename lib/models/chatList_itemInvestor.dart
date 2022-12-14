import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/models/investor.dart';
import 'package:fynder/models/startup.dart';
import 'package:fynder/services/storage.dart';

class chatList_itemInvestor extends StatefulWidget{
  final Startup user;
  final Investor chatUser;

  const chatList_itemInvestor({required this.user, required this.chatUser});

  @override
  _chatList_item createState() => _chatList_item();
}

class _chatList_item extends State<chatList_itemInvestor> {

  late Startup _user;
  late Investor _chatUser;

  @override
  void initState() {
    _chatUser = widget.chatUser;
    _user = widget.user;
    super.initState();
  }

  Future<String> getlastMessage () async{
    AsyncSnapshot<dynamic> snapshot = await FirebaseFirestore.instance.collection('chats')
        .doc('${_user.name}+${_chatUser.name}')
        .collection('messages')
        .limit(1)
        .orderBy("timestamp", descending: true)
        .snapshots() as AsyncSnapshot<dynamic>;
    return snapshot.data['text'] as String;
  }

  Future<String> getTimeStamp () async{
    AsyncSnapshot<dynamic> snapshot = await FirebaseFirestore.instance.collection('chats')
        .doc('${_user.name}+${_chatUser.name}')
        .collection('messages')
        .limit(1)
        .orderBy("timestamp", descending: true)
        .snapshots() as AsyncSnapshot<dynamic>;
    return snapshot.data['timestamp'] as String;
  }

  @override
  Widget build(BuildContext context){
    final lastMessage = getlastMessage();
    final lastTimeStamp = getTimeStamp();
    Storage storage = Storage();
    //String profileURL = storage.getURL(_chatUser.uid) as String;
    // TODO: implement build
    return ListTile(
      /*leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(profileURL),
      ),*/
      title: Text(_chatUser.name, style: TextStyle( //change data from database for all
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      ),
      subtitle: Row(
        children: [
          SizedBox(width: 3,
          ),
          Flexible(child: Container(
            child :Text(
              '$lastMessage',
              style: TextStyle(
                  fontSize: 13
              ),
            ),
          ),),
        ],
      ),
      trailing: Text("$lastTimeStamp"),
    );
  }

}