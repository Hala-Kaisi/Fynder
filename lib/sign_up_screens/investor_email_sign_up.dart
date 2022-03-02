// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/services/fire_auth.dart';
import 'package:fynder/services/validator.dart';
import 'package:fynder/sign_up_screens/investor_email_verification_page.dart';

class InvestorEmailSignUp extends StatefulWidget {
  const InvestorEmailSignUp({Key? key}) : super(key: key);

  @override
  _InvestorEmailSignUpState createState() => _InvestorEmailSignUpState();
}

class _InvestorEmailSignUpState extends State<InvestorEmailSignUp> {
  final _registerFormKey = GlobalKey<FormState>();

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  final double fontSize = 18;

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/FynderApplicationLogo.png',
              fit: BoxFit.cover),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Welcome To Fynder \n Investor Account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Form(
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: txtEmail,
                          focusNode: _focusEmail,
                          validator: (value) => Validator.validateEmail(
                            email: value!,
                          ),
                          decoration: InputDecoration(
                            hintText: "Email",
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: txtPassword,
                          focusNode: _focusPassword,
                          obscureText: true,
                          validator: (value) => Validator.validatePassword(
                            password: value!,
                          ),
                          decoration: InputDecoration(
                            hintText: "Password",
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32.0),
                        _isProcessing
                            ? CircularProgressIndicator()
                            : Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isProcessing = true;
                                        });

                                        if (_registerFormKey.currentState!
                                            .validate()) {
                                          User? user = await FireAuth
                                              .registerUsingEmailPassword(
                                            name: 'investor',
                                            email: txtEmail.text,
                                            password: txtPassword.text,
                                          );

                                          setState(() {
                                            _isProcessing = false;
                                          });

                                          if (user != null) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    investorProfilePage(
                                                        user: user),
                                              ),
                                              ModalRoute.withName('/'),
                                            );
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Sign up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
