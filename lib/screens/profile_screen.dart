// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_bottom.dart';
import 'package:fynder/shared/menu_drawer.dart';

import '../models/startup.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _currentUser;
  late String? ideaSummary;
  late String? personalWebsiteLink;
  late String? videoLink;
  late String? targetFunds;
  late String? marketSegment;
  late String? investmentType;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  final TextEditingController txtIdeaSummary = TextEditingController();
  final TextEditingController txtPersonalWebsiteLink = TextEditingController();
  final TextEditingController txtVideoLink = TextEditingController();
  final TextEditingController txtTargetFunds = TextEditingController();
  final TextEditingController txtMarketSegment = TextEditingController();
  final TextEditingController txtInvestmentType = TextEditingController();

  final double fontSize = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset('assets/FynderApplicationLogo.png',
              fit: BoxFit.cover),
          actions: <Widget>[ActionsMenu(user: _currentUser)]),
      bottomNavigationBar: MenuBottom(user: _currentUser),
      drawer: MenuDrawer(user: _currentUser),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<Startup?>(
              stream: getUserData(),
              builder: (context, snapshot) {
                Startup? startup = snapshot.data;
                ideaSummary = startup?.ideaSummary;
                personalWebsiteLink = startup?.personalLink;
                videoLink = startup?.videoLink;
                targetFunds = startup?.targetFunds;
                marketSegment = startup?.marketSegment;
                investmentType = startup?.investmentType;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('$ideaSummary'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextField(
                        controller: txtIdeaSummary,
                        decoration: InputDecoration(hintText: 'Idea Summary'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('$personalWebsiteLink'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextField(
                        controller: txtPersonalWebsiteLink,
                        decoration:
                            InputDecoration(hintText: 'Personal Website Link'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('$videoLink'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextField(
                        controller: txtVideoLink,
                        decoration:
                            InputDecoration(hintText: 'Elevator Speech Link'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('$targetFunds'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextField(
                        controller: txtTargetFunds,
                        decoration: InputDecoration(hintText: 'Target Funds'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('$marketSegment'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextField(
                        controller: txtMarketSegment,
                        decoration: InputDecoration(hintText: 'Market Segment'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('$investmentType'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextField(
                        controller: txtInvestmentType,
                        decoration:
                            InputDecoration(hintText: 'Investment Type'),
                      ),
                    ),
                    ElevatedButton(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Stream<Startup?> getUserData() {
    return FirebaseFirestore.instance
        .collection('userlist')
        .doc(_currentUser.uid)
        .get()
        .then((snapshot) {
      try {
        return Startup.fromSnapshot(snapshot);
      } catch (e) {
        return null;
      }
    }).asStream();
  }
}
