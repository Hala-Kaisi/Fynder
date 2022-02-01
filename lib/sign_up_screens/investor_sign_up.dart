// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class InvestorSignUp extends StatelessWidget {
  const InvestorSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Image.asset('assets/FynderApplicationLogo.png', fit: BoxFit.cover),
      ),
      body: Center(
        child: Text("Investor Sign Up"),
      ),
    );
  }
}

