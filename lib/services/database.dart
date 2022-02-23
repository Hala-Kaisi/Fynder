import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fynder/models/user_profile.dart';
import 'package:fynder/screens/user_list.dart';

class DatabaseService {

  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userlist');

  Future updateUserData(String name, String surname, int age) async {
    return await userCollection.doc(uid).set({
      'name' : name,
      'surname' : surname,
      'age' : age
    });
  }

  // user list from snapshot
  List<UserProfile> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return UserProfile(
          name: doc.get('name') ?? '',
          surname: doc.get('surname') ?? '',
          age: doc.get('age') ?? 0
      );
    }).toList();
  }

  Stream<List<UserProfile>> get users {
    return userCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

}
