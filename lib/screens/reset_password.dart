import 'package:flutter/material.dart';
import 'package:fynder/screens/log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetScreen extends StatefulWidget {
  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController controller = TextEditingController();
  final _focusEmail = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(title: const Text('Reset Password')),
        ////
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "Enter recovery email",
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: controller.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogIn()));
                  });
                },
                child: Text("Send recovery link")),
          ],
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       ElevatedButton(
      //           onPressed: () async {
      //             FirebaseAuth.instance
      //                 .sendPasswordResetEmail(email: controller.text)
      //                 .then((value) {
      //               Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => LogIn()));
      //             });
      //           },
      //           child: Text("Send recovery link"))
      //     ],
      //   ),
      // ),
    );
  }
}
    // ignore: empty_statements
    
  

