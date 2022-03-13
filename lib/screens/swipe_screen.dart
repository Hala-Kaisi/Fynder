import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fynder/models/investor.dart';
import 'package:fynder/models/startup.dart';
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

class _SwipeScreenState extends State<SwipeScreen> with TickerProviderStateMixin {
  late User _currentUser;
  String matchedID = '';
  late var isStartup = true;
  late var usersList = [];
  List<dynamic> investorsCards = [];
  List<dynamic> startupsCards = [];
  DatabaseService database = DatabaseService();
  late var userlist = FirebaseFirestore.instance.collection('userslist').get();
  late Startup _currentUserTypeStartup;
  late Investor _currentUserTypeInvestor;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  late CardController controller;

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
        if(!snapshot.hasData){
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/WellDone!.png'),
              ),
            ),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            QuerySnapshot snap = snapshot.data as QuerySnapshot<Object?>;
            List<DocumentSnapshot> documents = snap.docs;
            if(_currentUser.displayName != "startup"){
              isStartup = false;
              getStartupsCards(storage, documents);
              return createStack();
            }
            else {
              getInvestorCards(storage, documents);
              return createStack();
            }
            }
        }
      );
    }

  Widget createStack() {
    var size = MediaQuery.of(context).size;
    var currentIndex = 0;
    if(isStartup){
    return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          height: 700,
            child: TinderSwapCard(
              cardController: controller = CardController(),
              swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
                if (align.x < 0) {
                } else if (align.x > 0) {
                  investorSwipedRight(investorsCards[currentIndex]);
                }
                // print(itemsTemp.length);
              },
              swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
                currentIndex = index;
              },
              swipeDown: false,
              swipeUp: false,
              totalNum: investorsCards.length,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: 700,
              minWidth: MediaQuery.of(context).size.width * 0.75,
              minHeight: 500,
              cardBuilder: (context, index) =>
                  Container(
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
    else {
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: 700,
          child: TinderSwapCard(
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              if (align.x < 0) {} else if (align.x > 0) {
                startupSwipedRight(startupsCards[currentIndex]);
              }
            },
            swipeCompleteCallback: (CardSwipeOrientation orientation,
                int index) {
              currentIndex = index;
            },
            swipeDown: false,
            swipeUp: false,
            totalNum: startupsCards.length,
            maxWidth: MediaQuery
                .of(context)
                .size
                .width,
            maxHeight: 700,
            minWidth: MediaQuery
                .of(context)
                .size
                .width * 0.75,
            minHeight: 500,
            cardBuilder: (context, index) =>
                Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 2),
                    ],
                  ),
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
  }

  getInvestorCards(Storage storage, List<DocumentSnapshot> documents){
    for(int i = 0; i<documents.length; i++){
      DocumentSnapshot doc = documents[i];
      if (doc['startup'] == false && database.isSwipedRight(doc.id, _currentUser.uid) == false) {
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
    if(investorsCards.isEmpty){
      investorsCards.add(emptyDatabase());
    }
  }

  getStartupsCards(Storage storage, List<DocumentSnapshot> documents) {
    for (int i = 0; i < documents.length; i++) {
      DocumentSnapshot doc = documents[i];
      if (doc['startup'] == true &&
          database.isSwipedRight(doc.id, _currentUser.uid) == false) {
        startupsCards.add(cardContentStartup(
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
    if (startupsCards.isEmpty) {
      startupsCards.add(emptyDatabase());
    }
  }

  investorSwipedRight(cardContentInvestor investor){
    String investorName = investor.getName();
    FirebaseFirestore.instance
        .collection('userlist')
        .where('name', isEqualTo: investorName).get()
        .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
                database.swipedRight(doc.id, _currentUser.uid);
                database.checkMatch(doc.id, _currentUser.uid, doc['name'], _currentUserTypeStartup.name);
              });
            });
  }

  startupSwipedRight(cardContentStartup startup){
    String startupName = startup.getName();
    FirebaseFirestore.instance
        .collection('userlist')
        .where('name', isEqualTo: startupName).get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        database.swipedRight(doc.id, _currentUser.uid);
        database.checkMatch(doc.id, _currentUser.uid, doc['name'], _currentUserTypeInvestor.name);
      });
    });
  }

  emptyDatabase(){
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/WellDone!.png'),
          fit: BoxFit.fitWidth
        ),
      ),
    );
  }

  getCurrentUserType(){
    return FirebaseFirestore.instance.collection('userlist')
        .doc(_currentUser.uid).get().then((DocumentSnapshot documentSnapshot) => {
          if(isStartup){
            _currentUserTypeStartup = Startup.fromSnapshot(documentSnapshot)
          }
          else{
            _currentUserTypeInvestor = Investor.fromSnapshot(documentSnapshot)
          }
    });
  }

}
