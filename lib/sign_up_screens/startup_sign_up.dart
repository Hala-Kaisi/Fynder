// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class StartupSingUp extends StatefulWidget {
  const StartupSingUp({Key? key}) : super(key: key);

  @override
  _StartupSingUpState createState() => _StartupSingUpState();
}

class _StartupSingUpState extends State<StartupSingUp> {
  final TextEditingController txtIdeaSummary = TextEditingController();
  final TextEditingController txtPersonalWebsiteLink = TextEditingController();
  final TextEditingController txtVideoLink = TextEditingController();
  final TextEditingController txtTargetFunds = TextEditingController();
  final TextEditingController txtMarketSegment = TextEditingController();
  final TextEditingController txtInvestmentType = TextEditingController();

  final double fontSize = 18;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/FynderApplicationLogo.png',
              fit: BoxFit.cover),
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
                    controller: txtIdeaSummary,
                    decoration: InputDecoration(hintText: 'E-Mail'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: txtPersonalWebsiteLink,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: txtVideoLink,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: txtTargetFunds,
                    decoration: InputDecoration(hintText: 'First Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: txtMarketSegment,
                    decoration: InputDecoration(hintText: 'Last Name'),
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
                  child: TextField(
                    controller: txtInvestmentType,
                    decoration:
                        InputDecoration(hintText: 'Personal Website Link'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: txtInvestmentType,
                    decoration:
                        InputDecoration(hintText: 'Elevator Speech Link'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: txtInvestmentType,
                    decoration: InputDecoration(hintText: 'Target Funds'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: txtInvestmentType,
                    decoration: InputDecoration(hintText: 'Market Segment'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: txtInvestmentType,
                    decoration: InputDecoration(hintText: 'Investment Type'),
                  ),
                ),
                MaterialButton(
                  minWidth: 360,
                  height: 60,
                  onPressed: () {},
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
