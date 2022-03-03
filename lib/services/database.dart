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
    await userCollection.doc(uid).collection('matchList');
    await userCollection.doc(uid).collection('chats');
    return userCollection.doc(uid);
  }

  Future<void> saveStartupUserDataToFirestore(Startup startup) {
    return userCollection.doc(uid).set(startup.toMap());
  }

  Future<void> saveInvestorUserDataToFirestore(Investor investor) {
    return userCollection.doc(uid).set(investor.toMap());
  }
}
