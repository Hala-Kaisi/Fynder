// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_bottom.dart';
import 'package:fynder/shared/menu_drawer.dart';

import '../models/startup.dart';
import '../notifier/startup_provider.dart';

class StartupProfileScreen extends StatefulWidget {
  final User user;

  const StartupProfileScreen({required this.user});

  @override
  _StartupProfileScreenState createState() => _StartupProfileScreenState();
}

class _StartupProfileScreenState extends State<StartupProfileScreen> {
  late User _currentUser;

  late String? name;
  late String? ideaSummary;
  late String? personalWebsiteLink;
  late String? videoLink;
  late String? targetFunds;
  late String? marketSegment;
  late String? investmentType;
  late String? location;
  late String? picture;

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

  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtIdeaSummary = TextEditingController();
  final TextEditingController txtPersonalWebsiteLink = TextEditingController();
  final TextEditingController txtVideoLink = TextEditingController();
  final TextEditingController txtTargetFunds = TextEditingController();
  final TextEditingController txtMarketSegment = TextEditingController();
  final TextEditingController txtInvestmentType = TextEditingController();
  final TextEditingController txtPicture = TextEditingController();

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
                name = startup?.name;
                ideaSummary = startup?.ideaSummary;
                personalWebsiteLink = startup?.personalLink;
                videoLink = startup?.videoLink;
                targetFunds = startup?.targetFunds;
                marketSegment = startup?.marketSegment;
                investmentType = startup?.investmentType;
                location = startup?.location;
                picture = startup?.pic;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('$name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextField(
                        controller: txtName,
                        decoration: InputDecoration(hintText: 'Full Name'),
                      ),
                    ),
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
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('$picture'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextField(
                        controller: txtPicture,
                        decoration: InputDecoration(hintText: 'Picture'),
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
                        if (txtName.text != '') {
                          name = txtName.text;
                        }
                        if (txtIdeaSummary.text != '') {
                          ideaSummary = txtIdeaSummary.text;
                        }
                        if (txtPersonalWebsiteLink.text != '') {
                          personalWebsiteLink = txtPersonalWebsiteLink.text;
                        }
                        if (txtVideoLink.text != '') {
                          videoLink = txtVideoLink.text;
                        }
                        if (txtInvestmentType.text != '') {
                          investmentType = txtInvestmentType.text;
                        }
                        if (txtMarketSegment.text != '') {
                          marketSegment = txtMarketSegment.text;
                        }
                        if (txtTargetFunds.text != '') {
                          targetFunds = txtTargetFunds.text;
                        }
                        if (txtPicture.text != '') {
                          picture = txtPicture.text;
                        }
                        if (locationValue != '') {
                          location = locationValue;
                        }

                        StartupProvider startupProvider = StartupProvider(uid: _currentUser.uid);
                        startupProvider.changeName = name;
                        startupProvider.changeIdeaSummary = ideaSummary;
                        startupProvider.changePersonalLink =
                            personalWebsiteLink;
                        startupProvider.changeInvestmentType = investmentType;
                        startupProvider.changeMarketSegment = marketSegment;
                        startupProvider.changeTargetFunds = targetFunds;
                        startupProvider.changeVideoLink = videoLink;
                        startupProvider.changeLocation = locationValue;
                        startupProvider.changePic = picture;
                        startupProvider.changeUid = _currentUser.uid;
                        startupProvider.updateStartupProfile();

                        displayUpdatedUserData(snapshot);
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void displayUpdatedUserData(AsyncSnapshot<Startup?> snapshot) {
    setState(() {
      Startup? startup = snapshot.data;
      name = startup?.name;
      ideaSummary = startup?.ideaSummary;
      personalWebsiteLink = startup?.personalLink;
      videoLink = startup?.videoLink;
      targetFunds = startup?.targetFunds;
      marketSegment = startup?.marketSegment;
      investmentType = startup?.investmentType;
      location = startup?.location;
      picture = startup?.pic;
    });
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
