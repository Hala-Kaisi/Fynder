import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;

  DatabaseService(this.uid);

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userlist');

  Future updateUserData(String name, String surname, int age) async {
    return await userCollection.doc(uid).set({
      'name' : name,
      'surname' : surname,
      'age' : age
    });
  }


}
