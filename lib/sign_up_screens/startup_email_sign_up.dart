// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/services/fire_auth.dart';
import 'package:fynder/services/validator.dart';
import 'package:fynder/sign_up_screens/startup_email_verification_page.dart';

class StartupEmailSignUp extends StatefulWidget {
  @override
  _StartupEmailSignUpState createState() => _StartupEmailSignUpState();
}

class _StartupEmailSignUpState extends State<StartupEmailSignUp> {
  final _registerFormKey = GlobalKey<FormState>();

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();

  final double fontSize = 18;

  bool _isProcessing = false;
  bool hidePassword=true;
  bool hideconfirmPassword=true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
        _focusConfirmPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/FynderApplicationLogo.png', fit: BoxFit.cover),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Welcome To Fynder \n Start Up Account',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top:24,
                    bottom: 10,
                  ),
                  child: Form(
                      key: _registerFormKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: txtEmail,
                            focusNode: _focusEmail,
                            validator: (value) => Validator.validateEmail(
                              email: value!,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              labelText: 'Email',
                              helperText: '',
                              hintText: 'Email',
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextFormField(
                            controller: txtConfirmPassword,
                            focusNode: _focusConfirmPassword,
                            obscureText: hidePassword,
                            validator: (value) => Validator.validatePassword(
                              password: value!,
                            ),
                            decoration: InputDecoration(prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              helperText: '',
                              hintText: 'Password',
                              suffixIcon: InkWell(
                                onTap: _passwordView,
                                child: hidePassword ? Icon(Icons.visibility_off ): Icon(Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextFormField(
                            controller: txtPassword,
                            focusNode: _focusPassword,
                            obscureText: hideconfirmPassword,
                            decoration: InputDecoration(prefixIcon: Icon(Icons.lock),
                              labelText: 'Confirm Password',
                              helperText: '',
                              hintText: 'Confirm Password',
                              suffixIcon: InkWell(
                                onTap: _confirmPasswordView,
                                child: hideconfirmPassword ? Icon(Icons.visibility_off ): Icon(Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
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
                                              email: txtEmail.text,
                                              password: txtPassword.text,
                                            );

                                            setState(() {
                                              _isProcessing = false;
                                            });

                                            if (user != null && txtPassword.text==txtConfirmPassword.text) {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      startupProfilePage(user: user),
                                                ),
                                                ModalRoute.withName('/'),
                                              );
                                            }
                                          }
                                        },
                                        child: Text(
                                          'Sign up',),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _passwordView(){
    setState((){hidePassword=!hidePassword;});
  }
  void _confirmPasswordView(){
    setState((){hideconfirmPassword=!hideconfirmPassword;});
  }
}
