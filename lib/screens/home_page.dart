import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fynder/screens/choose_account_type.dart';
import 'package:fynder/screens/log_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    // for removing to need to enter email and password again in the same phone
    // if (user != null) {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => SwipeScreen(user: user),
    //     ),
    //   );
    // }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  // even space distribution
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Text(
                          "Welcome",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "To Fynder ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/welcome2.png"))),
                    ),
                    Column(
                      children: <Widget>[
                        // the login button
                        ElevatedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: Colors.black12),
                            ),
                            backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LogIn()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                            ),
                        ),
                        // creating the signup button
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChooseAccount()));
                          },
                          child: const Text(
                            "Sign up",
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
