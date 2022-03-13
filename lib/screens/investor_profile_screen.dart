// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/models/investor.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_bottom.dart';
import 'package:fynder/shared/menu_drawer.dart';

class InvestorProfileScreen extends StatefulWidget {
  final User user;

  const InvestorProfileScreen({required this.user});

  @override
  _InvestorProfileScreenState createState() => _InvestorProfileScreenState();
}

class _InvestorProfileScreenState extends State<InvestorProfileScreen> {
  late User _currentUser;
  late String? description;
  late String? personalWebsiteLink;
  late String? videoLink;
  late String? location;

  String locationValue = 'EU Zone';

  var locationList = [
    "EU Zone",
    "Middle East",
    "Asia",
    "USA",
    "North Africa",
    "Canada"
  ];

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPersonalWebsiteLink = TextEditingController();
  final TextEditingController txtVideoLink = TextEditingController();

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
          child: StreamBuilder<Investor?>(
              stream: getUserData(),
              builder: (context, snapshot) {
                Investor? investor = snapshot.data;
                description = investor?.description;
                personalWebsiteLink = investor?.personalLink;
                videoLink = investor?.videoLink;
                location = investor?.location;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('$description'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextField(
                        controller: txtDescription,
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
                        decoration: InputDecoration(hintText: 'Speech Link'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('$location'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            isEmpty: locationValue == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: locationValue,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    locationValue = newValue!;
                                    state.didChange(newValue);
                                  });
                                },
                                items: locationList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Stream<Investor?> getUserData() {
    return FirebaseFirestore.instance
        .collection('userlist')
        .doc(_currentUser.uid)
        .get()
        .then((snapshot) {
      try {
        return Investor.fromSnapshot(snapshot);
      } catch (e) {
        return null;
      }
    }).asStream();
  }
}
