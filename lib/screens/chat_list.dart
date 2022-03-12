import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_drawer.dart';
import 'package:fynder/shared/menu_bottom.dart';
import 'package:fynder/screens/chat_screen.dart';
import 'package:fynder/models/chatList_item.dart';
import 'package:fynder/screens/match_list.dart';


class chatList extends StatefulWidget {
  final User user;

  const chatList({required this.user});

  @override
  _chatList createState() => _chatList();
}

class _chatList extends State<chatList> {

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
        title:
        Image.asset('assets/FynderApplicationLogo.png', fit: BoxFit.cover),
        actions: <Widget>[ActionsMenu(user: _currentUser)],
      ),
      bottomNavigationBar: MenuBottom(user: _currentUser),
      drawer: MenuDrawer(user: _currentUser),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => matchList(user: _currentUser)),
          );
        }, //create a new chat and choose from match
        child: Icon(Icons.chat),
      ),
      //use ListView.Builder with a model of a chat to have a list of the models.
      body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('userlist')
                    .doc(_currentUser.uid)
                    .collection('chats')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                  if(!snapshot.hasData) {
                    return new Text('You have no chatrooms open.'
                        , textAlign: TextAlign.center);
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            User chatUser = snapshot.data.docs[index];
                            return
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                primary: Colors.white
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                    ChatScreen(user: _currentUser, chatUser: chatUser)),
                                  );
                                },
                                child: chatList_item(user: _currentUser, chatUser: chatUser)
                              );
                          }
                      );
                  }
                },
              ),
      );
  }
}
