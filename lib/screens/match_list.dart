import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/screens/chat_InvestorUser.dart';
import 'package:fynder/screens/chat_list_startups.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_drawer.dart';
import 'package:fynder/shared/menu_bottom.dart';
import 'package:fynder/models/matchList_item.dart';
import 'package:fynder/screens/chat_startupUser.dart';
import '../models/investor.dart';
import '../models/startup.dart';
import 'chat_list_investors.dart';


class matchList extends StatefulWidget {
  final User user;

  const matchList({required this.user});

  @override
  _matchList createState() => _matchList();
}

class _matchList extends State<matchList> {

  late User _currentUser;
  late Startup _currentUserStartup;
  late Startup _chatUserStartup;
  late Investor _currentUserInvestor;
  late Investor _chatUserInvestor;

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if(_currentUser.displayName == "startup") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => chatListInvestors(user: _currentUser)),
              );
            }
            else{
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => chatListStartups(user: _currentUser)),
              );
            }
          },
        ),
      ),
      drawer: MenuDrawer(user: _currentUser),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
                  .collection('userlist')
                  .doc(_currentUser.uid)
                  .collection('matchList')
                  .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            if(!snapshot.hasData) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/NoMatches.png'),
                  ),
                ),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        QuerySnapshot snap = snapshot.data as QuerySnapshot<Object?>;
                        List<DocumentSnapshot> documents = snap.docs;
                        DocumentSnapshot doc = documents[index];
                        String chatUserName = doc['name'];
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white
                            ),
                            onPressed: () async {
                              if(_currentUser.displayName == 'startup'){
                                await getUser(true);
                                await getChatUser(true, doc.id);
                                await FirebaseFirestore.instance
                                    .collection('userlist')
                                    .doc(_currentUserStartup.id)
                                    .collection('chats')
                                    .doc("${_currentUserStartup.name}+${_chatUserInvestor.name}").set({});
                                await FirebaseFirestore.instance
                                    .collection('userlist')
                                    .doc(_chatUserInvestor.id)
                                    .collection('chats')
                                    .doc("${_currentUserStartup.name}+${_chatUserInvestor.name}").set({});
                                FirebaseFirestore.instance
                                    .collection('chats')
                                    .doc('${_currentUserStartup.name}+${_chatUserInvestor.name}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      ChatScreenInvestor(user: _currentUserStartup, chatUser: _chatUserInvestor)),
                                );
                              }
                              else{
                                await getUser(false);
                                await getChatUser(false, doc.id);
                                await FirebaseFirestore.instance
                                    .collection('userlist')
                                    .doc(_currentUserInvestor.id)
                                    .collection('chats')
                                    .doc("${_chatUserStartup.name}+${_currentUserInvestor.name}").set({});
                                await FirebaseFirestore.instance
                                    .collection('userlist')
                                    .doc(_chatUserStartup.id)
                                    .collection('chats')
                                    .doc("${_chatUserStartup.name}+${_currentUserInvestor.name}").set({});
                                FirebaseFirestore.instance
                                    .collection('chats')
                                    .doc('${_chatUserStartup.name}+${_currentUserInvestor.name}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      ChatScreenStartup(user: _currentUserInvestor, chatUser: _chatUserStartup)),
                                );
                              }
                            },
                            child: matchList_item(matchName: chatUserName)
                        );
                      }
                  );
            }
          },
      ),
    );
  }
  getUser(bool isStartup) {
    return
      FirebaseFirestore.instance.collection('userlist')
          .doc(_currentUser.uid).get().then((
          DocumentSnapshot documentSnapshot) {
        if (isStartup) {
          _currentUserStartup = Startup.fromSnapshot(documentSnapshot);
          print(_currentUserStartup.name);
        }
        else {
          _currentUserInvestor = Investor.fromSnapshot(documentSnapshot);
        }
      });
  }

  getChatUser(bool isStartup, String chatUserID){
    return FirebaseFirestore.instance.collection('userlist')
        .doc(chatUserID). get ().then((DocumentSnapshot documentSnapshot) {
          if(isStartup){
            _chatUserInvestor = Investor.fromSnapshot(documentSnapshot);
            print(_chatUserInvestor.name);
          }
          else{
            _chatUserStartup = Startup.fromSnapshot(documentSnapshot);
          }
        });
  }
}

