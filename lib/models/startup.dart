import 'package:cloud_firestore/cloud_firestore.dart';

class Startup {
  final String name;
  final String ideaSummary;
  final String personalLink;
  final String videoLink;
  final String targetFunds;
  final String marketSegment;
  final String investmentType;
  final String? location;
  final String pic;

  Startup(
      {required this.name,
      required this.ideaSummary,
      required this.personalLink,
      required this.videoLink,
      required this.targetFunds,
      required this.marketSegment,
      required this.investmentType,
      required this.location,
      required this.pic});

  // send data to Firestore
  Map<String, dynamic> toMap() {
    return {
      'ideaSummary': ideaSummary,
      'personalLink': personalLink,
      'videoLink': videoLink,
      'targetFunds': targetFunds,
      'marketSegment': marketSegment,
      'investmentType': investmentType,
      'picture': pic,
      'name': name,
      'location': location,
      'investor': false,
      'startup': true
    };
  }

  // retrieve data from firestore
  Startup.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        ideaSummary = snapshot['ideaSummary'],
        personalLink = snapshot['personalLink'],
        videoLink = snapshot['videoLink'],
        targetFunds = snapshot['targetFunds'],
        marketSegment = snapshot['marketSegment'],
        investmentType = snapshot['investmentType'],
        location = snapshot['location'],
        pic = snapshot['picture'];
}
