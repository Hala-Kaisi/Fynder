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

  swipedRight(String matchedID, String ID) async {
    return {
      userCollection.doc(ID).collection('swipedRight').doc(matchedID).set({
      'userID': matchedID}),
    };
  }

  checkMatch(String matchedID, String ID) async {
    QuerySnapshot<Map<String, dynamic>> getSwipedRightList =await userCollection
          .doc(matchedID)
          .collection('swipedRight')
          .get();
    for(int i = 0; i < getSwipedRightList.docs.length; i++){
      if(getSwipedRightList.docs[i].exists){
        if(getSwipedRightList.docs[i].id == ID){
          return {
            userCollection.doc(ID).collection('matchList').doc(matchedID). set ({
            'userID': matchedID
            }),
            userCollection.doc(matchedID).collection('matchList').doc(ID). set ({
              'userID': ID
            }),
          };
        }
      }
    }
  }

  isSwipedRight(String cardID, String ID) async{
    QuerySnapshot<Map<String, dynamic>> getSwipedRightList = await userCollection
        .doc(ID)
        .collection('swipedRight')
        .get();
    for(int i = 0; i < getSwipedRightList.docs.length; i++){
      if(getSwipedRightList.docs[i].exists){
          return getSwipedRightList.docs[i].id == cardID;
      }
    }
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
