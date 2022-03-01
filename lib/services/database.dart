import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fynder/models/startup.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userlist');

  Future createUser(String name) async {
    return userCollection.doc(uid);
  }

  updateStartupData(
      String name,
      bool startup,
      bool investor,
      String ideaSummary,
      String personalLink,
      String videoLink,
      String targetFunds,
      String marketSegment,
      String investmentType,
      String pic) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'startup': true,
      'investor': false,
      'ideaSummary': ideaSummary,
      'websiteLink': personalLink,
      'videoLink': videoLink,
      'targetFunds': targetFunds,
      'marketSegment': marketSegment,
      'investmentType': investmentType,
      'picture': pic
    });
  }

  updateInvestorData(
      String name,
      bool startup,
      bool investor,
      String description,
      String personalLink,
      String videoLink,
      String pic) async {
    return await userCollection.doc(uid).set({
      'fullName': name,
      'startup': false,
      'investor': true,
      'ideaSummary': description,
      'websiteLink': personalLink,
      'videoLink': videoLink,
      'profilePicture': pic
    });
  }
}
