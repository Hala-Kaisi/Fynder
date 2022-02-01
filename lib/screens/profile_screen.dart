// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_bottom.dart';
import 'package:fynder/shared/menu_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
          actions: <Widget>[ActionsMenu()]),
      bottomNavigationBar: MenuBottom(),
      drawer: MenuDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                child: TextField(
                  controller: txtMarketSegment,
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
          ),
        ),
      ),
    );
  }
}
