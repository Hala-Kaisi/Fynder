// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/models/investor.dart';
import 'package:fynder/notifier/investor_provider.dart';
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

  String locationValue = 'EU Zone';

  var locationList = [
    "EU Zone",
    "Middle East",
    "Asia",
    "USA",
    "North Africa",
    "Canada"
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
                  InvestorProvider investorProvider =
                      InvestorProvider(uid: _currentUser.uid);
                  investorProvider.changeDescription = txtDescription.text;
                  investorProvider.changeVideoLink = txtVideoLink.text;
                  investorProvider.changePersonalLink =
                      txtPersonalWebsiteLink.text;
                  investorProvider.changeLocation = locationValue;
                  investorProvider.saveInvestorProfile();

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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("EU Zone"), value: "EU"),
      DropdownMenuItem(child: Text("Middle East"), value: "ME"),
      DropdownMenuItem(child: Text("North Africa"), value: "NA"),
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "CA"),
    ];
    return menuItems;
  }
}
