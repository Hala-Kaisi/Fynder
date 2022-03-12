import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/services/database.dart';
import 'package:fynder/services/storage.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_drawer.dart';
import 'package:fynder/shared/menu_bottom.dart';
import '../models/cardContentInvestor.dart';
import '../models/cardContentStartup.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';

class SwipeScreen extends StatefulWidget {
  final User user;

  const SwipeScreen({required this.user});

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  late User _currentUser;
  String matchedID = '';
  late var isStartup = true;
  late var usersList = [];
  List<dynamic> investorsCards = [];
  List<dynamic> startupsCards = [];
  DatabaseService database = DatabaseService();
  late var userlist = FirebaseFirestore.instance.collection('userslist').get();

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Storage storage = Storage();
    checkUserType();
    return Scaffold(
      appBar: AppBar(
        title:
        Image.asset('assets/FynderApplicationLogo.png', fit: BoxFit.cover),
        actions: <Widget>[ActionsMenu(user: _currentUser)],
      ),
      bottomNavigationBar: MenuBottom(user: _currentUser),
      drawer: MenuDrawer(user: _currentUser),
      body: checkCorrectUsers(storage),
    );
  }

  void checkUserType() {
    if (_currentUser.displayName == "investor") {
      isStartup = false;
    }
  }

  checkCorrectUsers(Storage storage) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("userlist").snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            QuerySnapshot snap = snapshot.data as QuerySnapshot<Object?>;
            List<DocumentSnapshot> documents = snap.docs;
            getInvestorCards(storage, documents);
            getStartupsCards(storage, documents);
            return createStack();
            }
        }
      );
    }

  Widget createStack() {
    var size = MediaQuery.of(context).size;
    if(isStartup){
    return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          height: 700,
            child: TinderSwapCard(
              totalNum: investorsCards.length,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: 700,
              minWidth: MediaQuery.of(context).size.width * 0.75,
              minHeight: 700,
              cardBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 2),
                ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Container(
                      width: size.width,
                      height:600,
                      child: investorsCards[index],
                    ),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
    return Padding(
      padding: const EdgeInsets.only(top:5),
      child: Container(
        height: 700,
        child: TinderSwapCard(
          swipeDown: false,
          swipeUp: false,
          totalNum: startupsCards.length,
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 700,
          minWidth: MediaQuery.of(context).size.width * 0.75,
          minHeight: 500,
          cardBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2),
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                  width: size.width,
                  height: 600,
                  child: startupsCards[index],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

  getInvestorCards(Storage storage, List<DocumentSnapshot> documents){
    for(int i = 0; i<documents.length; i++){
      DocumentSnapshot doc = documents[i];
      if (doc['startup'] == false) {
        investorsCards.add(
            cardContentInvestor(
                name: doc['name'],
                asset: storage.getURL(doc['picture']).toString(),
                description: doc['description'],
                websiteLink: doc['personalLink'],
                videoLink: doc['videoLink'],
                location: doc['location']));
      }
    }
  }

  getStartupsCards(Storage storage, List<DocumentSnapshot> documents){
    for(int i = 0; i<documents.length; i++){
      DocumentSnapshot doc = documents[i];
      if (doc['startup'] == true) {
        startupsCards.add( cardContentStartup(
            name: doc['name'],
            asset: storage.getURL(doc['picture']),
            description: doc['ideaSummary'],
            websiteLink: doc['personalLink'],
            videoLink: doc['videoLink'],
            location: doc['location'],
            investmentType: doc['investmentType'],
            marketSegment: doc['marketSegment'],
            targetFunds: doc['targetFunds']));
      }
    }
  }

}
