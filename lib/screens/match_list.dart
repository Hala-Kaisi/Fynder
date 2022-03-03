import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_drawer.dart';
import 'package:fynder/shared/menu_bottom.dart';
import 'package:fynder/models/matchList_item.dart';
import 'package:fynder/screens/chat_screen.dart';


class matchList extends StatefulWidget {
  final User user;

  const matchList({required this.user});

  @override
  _matchList createState() => _matchList();
}

class _matchList extends State<matchList> {

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
        Text('New Chat'),
        actions: <Widget>[ActionsMenu(user: _currentUser)],
      ),
      bottomNavigationBar: MenuBottom(user: _currentUser),
      drawer: MenuDrawer(user: _currentUser),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
                  .collection('userlist')
                  .doc(_currentUser.uid)
                  .collection('matchList')
                  .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            if(!snapshot.hasData)
              return new Text('You have not been matched with anyone yet to start a conversation.'
              , textAlign: TextAlign.center);
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        User chatUser = snapshot.data.docs[index];
                        String chatUserName = chatUser.displayName!;
                        String userName = _currentUser.displayName!;
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                .collection('userlist')
                                .doc(_currentUser.uid)
                                .collection('chats')
                                .doc(chatUser.uid);
                              FirebaseFirestore.instance
                                .collection('chats')
                                .doc('$chatUserName+$userName');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    ChatScreen(user: _currentUser, chatUser: chatUser)),
                              );
                            },
                            child: matchList_item(user: chatUser)
                        );
                      }
                  );
            }
          },
      ),
    );
  }
}

