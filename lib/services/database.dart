import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fynder/models/startup.dart';

import '../models/investor.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userlist');

  Future createUser(String name) async {
    return {
    userCollection.doc(uid),
    userCollection.doc(uid).collection('matchList').doc('test'),
    userCollection.doc(uid).collection('chats').doc('test'),
    userCollection.doc(uid).collection('swipedRight').doc('test'),
    };
  }

  Future<bool> swipedRight(String matchedID) async {
    userCollection.doc(uid).collection('swipedRight').doc(matchedID);
    var matched = await userCollection.doc(matchedID).collection('swipedRight')
        .doc(uid).get();
    if(matched.exists){
      userCollection.doc(uid).collection('matchList').doc(matchedID);
      return true;
    }
    return false;
  }

  Future<void> swipedLeft(String unmatchedID) async {
    userCollection.doc(uid).collection('swipedLeft').doc(unmatchedID);
  }

  Future<void> saveStartupUserDataToFirestore(Startup startup) {
    return userCollection.doc(uid).set(startup.toMap());
  }

  Future<void> saveInvestorUserDataToFirestore(Investor investor) {
    return userCollection.doc(uid).set(investor.toMap());
  }
}
