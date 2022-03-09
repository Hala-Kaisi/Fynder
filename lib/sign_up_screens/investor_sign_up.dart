// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/models/investor.dart';
import 'package:fynder/screens/swipe_screen.dart';
import 'package:fynder/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fynder/services/storage.dart';

class InvestorSignUp extends StatefulWidget {
  final User user;

  const InvestorSignUp({required this.user});

  @override
  _InvestorSignUpState createState() => _InvestorSignUpState();
}

class _InvestorSignUpState extends State<InvestorSignUp> {
  late User _currentUser;
  final TextEditingController txtName = TextEditingController();
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
    final Storage storage = Storage();
    final investorUID = _currentUser.uid;
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
                  controller: txtName,
                  decoration: InputDecoration(hintText: 'Full Name'),
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
              MaterialButton(
                minWidth: 360,
                height: 60,
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  final imagePath = image?.path;
                  storage.uplaodFile(imagePath!, 'investorPic-$investorUID');
                },
                color: const Color(0xff0095FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  'Upload Profile Picture',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
              MaterialButton(
                minWidth: 360,
                height: 60,
                onPressed: () {
                  Investor investor = Investor(
                      name: txtName.text,
                      description: txtDescription.text,
                      videoLink: txtVideoLink.text,
                      personalLink: txtPersonalWebsiteLink.text,
                      pic: 'investorPic-$investorUID');
                  DatabaseService(uid: _currentUser.uid)
                      .saveInvestorUserDataToFirestore(investor);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SwipeScreen(user: _currentUser),
                    ),
                  );
                },
                color: const Color(0xff0095FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  'Save and Proceed',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
