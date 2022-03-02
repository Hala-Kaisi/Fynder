// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/screens/swipe_screen.dart';
import 'package:fynder/services/fire_auth.dart';
import 'package:fynder/services/validator.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Welcome')),
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/FynderApplicationLogo.png',
                    fit: BoxFit.cover),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        focusNode: _focusEmail,
                        validator: (value) => Validator.validateEmail(
                          email: value!,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Email',
                          helperText: '',
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        controller: passwordController,
                        focusNode: _focusPassword,
                        obscureText: hidePassword,
                        validator: (value) => Validator.validatePassword(
                          password: value!,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          helperText: '',
                          hintText: 'Password',
                          suffixIcon: InkWell(
                            onTap: _passwordView,
                            child: hidePassword
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password',
                      ),
                    ),
                    _isProcessing
                        ? CircularProgressIndicator()
                        : Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(
                              10, 10, 10, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              _focusEmail.unfocus();
                              _focusPassword.unfocus();

                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isProcessing = true;
                                });

                                User? user = await FireAuth
                                    .signInUsingEmailPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                setState(() {
                                  _isProcessing = false;
                                });

                                checkUserLoged(user, context);
                              }
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Row(
                          children: <Widget>[
                            const Text('Does not have account?'),
                            TextButton(
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {

                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkUserLoged(User? user, BuildContext context) {
    if (user != null) {
      Navigator.of(context)
          .pushReplacement(
          MaterialPageRoute(
              builder: (context) =>
                  SwipeScreen(user: user,))
        //ProfilePage(user: user),
      );
    }
  }
  void _passwordView() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }
}
