// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/models/startup.dart';
import 'package:fynder/screens/swipe_screen.dart';
import 'package:fynder/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fynder/services/storage.dart';

class StartupSignUp extends StatefulWidget {
  final User user;

  const StartupSignUp({required this.user});

  @override
  _StartupSignUpState createState() => _StartupSignUpState();
}

class _StartupSignUpState extends State<StartupSignUp> {
  late User _currentUser;
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtIdeaSummary = TextEditingController();
  final TextEditingController txtPersonalWebsiteLink = TextEditingController();
  final TextEditingController txtVideoLink = TextEditingController();
  final TextEditingController txtTargetFunds = TextEditingController();
  final TextEditingController txtMarketSegment = TextEditingController();
  final TextEditingController txtInvestmentType = TextEditingController();
  String locationValue = 'EU Zone';
  String segmentValue = 'IT';

  var locationList = [
    "EU Zone",
    "Middle East",
    "Asia",
    "USA",
    "North Africa",
    "Canada"
  ];

  var marketSegmentList = [
    "IT",
    "Health",
    "Education",
    "Tourism",
    "Military",
    "Science"
  ];
  final double fontSize = 18;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    final startupUID = _currentUser.uid;
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
                  'Please fill the form',
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
                  controller: txtIdeaSummary,
                  decoration: InputDecoration(hintText: 'Idea Summary'),
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
                  decoration: InputDecoration(hintText: 'Elevator Speech Link'),
                ),
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
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      isEmpty: segmentValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: segmentValue,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              segmentValue = newValue!;
                              state.didChange(newValue);
                            });
                          },
                          items: marketSegmentList.map((String value) {
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
                child: TextField(
                  controller: txtInvestmentType,
                  decoration: InputDecoration(hintText: 'Investment Type'),
                ),
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
              MaterialButton(
                minWidth: 360,
                height: 60,
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  final imagePath = image?.path;
                  storage.uplaodFile(imagePath!, 'startupPic-$startupUID');
                },
                color: const Color(0xff0095FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  'Upload Startup Picture',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: 360,
                height: 60,
                onPressed: () {
                  Startup startup = Startup(
                      name: txtName.text,
                      ideaSummary: txtIdeaSummary.text,
                      personalLink: txtPersonalWebsiteLink.text,
                      videoLink: txtVideoLink.text,
                      targetFunds: txtTargetFunds.text,
                      marketSegment: segmentValue,
                      investmentType: txtInvestmentType.text,
                      location: locationValue,
                      pic: 'startupPic-$startupUID',
                      id: _currentUser.uid);
                  DatabaseService(uid: _currentUser.uid)
                      .saveStartupUserDataToFirestore(startup);
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
