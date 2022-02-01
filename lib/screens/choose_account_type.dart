// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fynder/sign_up_screens/investor_sign_up.dart';
import 'package:fynder/sign_up_screens/startup_sign_up.dart';

class ChooseAccount extends StatefulWidget {
  const ChooseAccount({Key? key}) : super(key: key);

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  final double fontSize = 18;
  bool isStartup = true;
  bool isInvestor = false;

  StartupSingUp startupSignUp = StartupSingUp();
  InvestorSignUp investorSignUp = InvestorSignUp();

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
              child: ToggleButtons(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Startup", style: TextStyle(fontSize: fontSize)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Investor", style: TextStyle(fontSize: fontSize)),
                ),
              ], isSelected: isSelected, onPressed: toggleMeasure),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
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
            Text(
              '',
              style: TextStyle(
                fontSize: fontSize,
              ),
            )
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
