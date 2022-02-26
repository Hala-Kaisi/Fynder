import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fynder/models/user_profile.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userlist');

  Future updateUserData(String name) async {
    return await userCollection.doc(uid).set({'name': name});
  }

  updateStartupData(
      bool startup,
      bool investor,
      String ideaSummary,
      String personalLink,
      String videoLink,
      String targetFunds,
      String marketSegment,
      String investmentType) async {
    return await userCollection.doc(uid).set({
      'startup': true,
      'investor': false,
      'ideaSummary': ideaSummary,
      'websiteLink': personalLink,
      'videoLink': videoLink,
      'targetFunds': targetFunds,
      'marketSegment': marketSegment,
      'investmentType': investmentType
    });
  }

  updateInvestorData(bool startup, bool investor, String description,
      String personalLink, String videoLink) async {
    return await userCollection.doc(uid).set({
      'startup': false,
      'investor': true,
      'ideaSummary': description,
      'websiteLink': personalLink,
      'videoLink': videoLink
    });
  }

  // user list from snapshot
  List<UserProfile> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return UserProfile(
          name: doc.get('name') ?? '',
          surname: doc.get('surname') ?? '',
          age: doc.get('age') ?? 0);
    }).toList();
  }

  Stream<List<UserProfile>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
