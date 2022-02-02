// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fynder/sign_up_screens/investor_sign_up.dart';

class InvestorEmailSignUp extends StatefulWidget {
  const InvestorEmailSignUp({Key? key}) : super(key: key);

  @override
  _InvestorEmailSignUpState createState() => _InvestorEmailSignUpState();
}

class _InvestorEmailSignUpState extends State<InvestorEmailSignUp> {
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  final double fontSize = 18;

  @override
  void initState() {
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
                  controller: txtEmail,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtPassword,
                  decoration: InputDecoration(hintText: 'Password'),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => InvestorSignUp()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
