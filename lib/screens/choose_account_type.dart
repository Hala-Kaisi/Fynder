// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fynder/sign_up_screens/investor_email_sign_up.dart';
import 'package:fynder/sign_up_screens/startup_email_sign_up.dart';

class ChooseAccount extends StatefulWidget {
  const ChooseAccount({Key? key}) : super(key: key);

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  final double fontSize = 18;
  bool isStartup = true;
  bool isInvestor = false;

  StartupEmailSignUp startupSignUp = StartupEmailSignUp();
  InvestorEmailSignUp investorSignUp = InvestorEmailSignUp();

  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [isStartup, isInvestor];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Account"),
      ),
      body: Center(
        // allows scrolling when does not fit in the screen
        child: Stack(
          children: [
            Align(
              child: ToggleButtons(
                  borderRadius: BorderRadius.circular(50),
                  fillColor: Colors.lightBlue,
                  selectedColor: Colors.white,
                  textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
                  children: const [
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                      child:
                      Text("Startup"),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                      child: Text("Investor"),
                    )
                  ], isSelected: isSelected, onPressed: toggleMeasure),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                EdgeInsets.symmetric(horizontal: 45, vertical: 200),
                child: ElevatedButton(
                  child: Text(
                    'Proceed'
                  ),
                  onPressed: () {
                    if (isStartup == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => startupSignUp));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => investorSignUp));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isStartup = true;
      isInvestor = false;
    } else {
      isStartup = false;
      isInvestor = true;
    }
    setState(() {
      isSelected = [isStartup, isInvestor];
    });
  }
}
