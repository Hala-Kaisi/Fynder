import 'package:cloud_firestore/cloud_firestore.dart';

class Investor {
  final String name;
  final String description;
  final String personalLink;
  final String videoLink;
  final String? location;
  final String pic;

  Investor(
      {required this.name,
      required this.description,
      required this.personalLink,
      required this.videoLink,
      required this.location,
      required this.pic});

  // send data to Firestore
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'personalLink': personalLink,
      'videoLink': videoLink,
      'picture': pic,
      'name': name,
      'location': location,
      'investor': true,
      'startup': false
    };
  }

  // retrieve data from firestore
  Investor.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        description = snapshot['description'],
        personalLink = snapshot['personalLink'],
        videoLink = snapshot['videoLink'],
        location = snapshot['location'],
        pic = snapshot['picture'];
}
