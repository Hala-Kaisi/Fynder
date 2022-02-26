

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fynder/models/user_profile.dart';

class DatabaseService {

  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userlist');

  Future updateUserData(String name) async {
    return await userCollection.doc(uid).set({
      'name' : name
    });
  }

  updateStartupData(String name, bool startup, bool investor, String ideaSummary,
      String personalLink, String videoLink, String targetFunds, String marketSegment,
      String investmentType, String pic) async {
    return await userCollection.doc(uid).set({
      'name' : name,
      'startup' : true,
      'investor' : false,
      'ideaSummary' : ideaSummary,
      'websiteLink' : personalLink,
      'videoLink' : videoLink,
      'targetFunds' : targetFunds,
      'marketSegment' : marketSegment,
      'investmentType' : investmentType,
      'pictrue' : pic
    });
  }

  updateInvestorData(String name, bool startup, bool investor, String description,
      String personalLink, String videoLink, String pic) async {
    return await userCollection.doc(uid).set({
      'fullName' : name,
      'startup' : false,
      'investor' : true,
      'ideaSummary' : description,
      'websiteLink' : personalLink,
      'videoLink' : videoLink,
      'profilePicture' : pic
    });
  }

  // user list from snapshot
  List<UserProfile> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return UserProfile(
          name: doc.get('name') ?? ''
      );
    }).toList();
  }

  Stream<List<UserProfile>> get users {
    return userCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

}
