import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_drawer.dart';
import 'package:fynder/shared/menu_bottom.dart';
import 'package:fynder/screens/chat_startupUser.dart';
import 'package:fynder/models/chatList_itemStartup.dart';
import 'package:fynder/screens/match_list.dart';

import '../models/investor.dart';
import '../models/startup.dart';
import 'chat_InvestorUser.dart';


class chatListStartups extends StatefulWidget {
  final User user;

  const chatListStartups({required this.user});

  @override
  _chatList createState() => _chatList();
}

class _chatList extends State<chatListStartups> {

  late User _currentUser;
  late Investor _currentUserInvestor;
  late Startup _startup;

  @override
  void initState() {
    _currentUser = widget.user;
    getInvestor();
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
            MaterialPageRoute(
                builder: (context) => matchList(user: _currentUser)),
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
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/NoConversations.png'),
                ),
              ),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    QuerySnapshot snap = snapshot.data as QuerySnapshot<
                        Object?>;
                    List<DocumentSnapshot> documents = snap.docs;
                    DocumentSnapshot doc = documents[index];
                    getStartup(doc.id);
                    return
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  ChatScreenStartup(user: _currentUserInvestor,
                                      chatUser: _startup)),
                            );
                          },
                          child: chatList_itemStartup(
                              user: _currentUserInvestor, chatUser: _startup)
                      );
                  }
              );
          }
        },
      ),
    );
  }

  getInvestor() {
    return FirebaseFirestore.instance.collection('userlist')
        .doc(_currentUser.uid).get().then((DocumentSnapshot documentSnapshot) {
      _currentUserInvestor = Investor.fromSnapshot(documentSnapshot);
    });
  }

  getStartup(String id) {
    return
      FirebaseFirestore.instance.collection('userlist')
          .doc(id).get().then((DocumentSnapshot documentSnapshot) {
        _startup = Startup.fromSnapshot(documentSnapshot);
      });
  }
}
