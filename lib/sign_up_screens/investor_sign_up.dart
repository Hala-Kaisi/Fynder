// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/screens/swipe_screen.dart';
import 'package:fynder/services/database.dart';

class InvestorSignUp extends StatefulWidget {

  final User user;
  const InvestorSignUp({required this.user});

  @override
  _InvestorSignUpState createState() => _InvestorSignUpState();
}

class _InvestorSignUpState extends State<InvestorSignUp> {

  late User _currentUser;
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPersonalWebsiteLink = TextEditingController();
  final TextEditingController txtVideoLink = TextEditingController();

  final double fontSize = 18;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Image.asset('assets/FynderApplicationLogo.png', fit: BoxFit.cover),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Welcome To Fynder',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtDescription,
                  decoration: InputDecoration(hintText: 'Short Description'),
                ),
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
                child: TextField(
                  controller: txtVideoLink,
                  decoration: InputDecoration(hintText: 'Youtube Video Link'),
                ),
              ),
              ElevatedButton(
                child: Text(
                  'Save and Proceed',
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
                onPressed: () {
                  DatabaseService(uid : _currentUser.uid).updateInvestorData(
                      false, true, txtDescription.text,
                      txtPersonalWebsiteLink.text,
                      txtVideoLink.text);
                  Navigator.of(context)
                      .pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          SwipeScreen(user: _currentUser),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
