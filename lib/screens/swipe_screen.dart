import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/services/storage.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_drawer.dart';
import 'package:fynder/shared/menu_bottom.dart';
import '../enum/card_overlay.dart';
import '../models/cardContentInvestor.dart';
import '../models/cardContentStartup.dart';

class SwipeScreen extends StatefulWidget {
  final User user;

  const SwipeScreen({required this.user});

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  late final SwipableStackController _controller;
  late User _currentUser;
  late var isStartup = true;
  late var usersList = [];

  void _listenController() {
    setState(() {});
  }

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  Widget build(BuildContext context) {
    checkUserType();
    checkCorrectUsers();
    Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title:
        Image.asset('assets/FynderApplicationLogo.png', fit: BoxFit.cover),
        actions: <Widget>[ActionsMenu(user: _currentUser)],
      ),
      bottomNavigationBar: MenuBottom(user: _currentUser),
      drawer: MenuDrawer(user: _currentUser),
      body: SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SwipableStack(
                        itemCount: usersList.length,
                        detectableSwipeDirections: const {
                          SwipeDirection.right,
                          SwipeDirection.left,
                        },
                        allowVerticalSwipe: false,
                        controller: _controller,
                        stackClipBehaviour: Clip.none,
                        onSwipeCompleted: (index, direction) {
                          if(isStartup) {
                            const Text('No more investors to check. Good job!'
                                , textAlign: TextAlign.center);
                          }
                          else {
                            const Text('No more startups to check. Good job!'
                                , textAlign: TextAlign.center);
                          }
                        },
                        horizontalSwipeThreshold: 0.8,
                        builder: (context, properties) {
                          final indexPicURL = storage.getURL(usersList[properties.index].data()['pic']) as String;
                          if(isStartup) {
                            return Stack(
                              children: [
                                cardContentInvestor(
                                  asset: indexPicURL,
                                  description: usersList[properties.index].data()['description'],
                                  location: usersList[properties.index].data()['location'],
                                  name: usersList[properties.index].data()['name'],
                                  videoLink: usersList[properties.index].data()['videoLink'],
                                  websiteLink: usersList[properties.index].data()['websiteLink'],
                                ),
                                // more custom overlay possible than with overlayBuilder
                                if (properties.stackIndex == 0 &&
                                    properties.direction != null)
                                  CardOverlay(
                                    swipeProgress: properties.swipeProgress,
                                    direction: properties.direction!,
                                  )
                              ],
                            );
                          }
                          else {
                            return Stack(
                              children: [
                                cardContentStartup(
                                  asset: indexPicURL,
                                  description: usersList[properties.index].data()['description'],
                                  location: usersList[properties.index].data()['location'],
                                  name: usersList[properties.index].data()['name'],
                                  videoLink: usersList[properties.index].data()['videoLink'],
                                  websiteLink: usersList[properties.index].data()['websiteLink'],
                                  investmentType: usersList[properties.index].data()['investmentType'],
                                  marketSegment: usersList[properties.index].data()['marketSegment'],
                                  targetFunds: usersList[properties.index].data()['targetFunds'],
                                ),
                                // more custom overlay possible than with overlayBuilder
                                if (properties.stackIndex == 0 &&
                                    properties.direction != null)
                                  CardOverlay(
                                    swipeProgress: properties.swipeProgress,
                                    direction: properties.direction!,
                                  )
                              ],
                            );
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
  Future<void> checkUserType() async {
    final getData = await FirebaseFirestore.instance
        .collection('userlist')
        .doc(_currentUser.uid)
        .get();
    isStartup = await getData.data()!['startup'];
  }

  Future<void> checkCorrectUsers() async {
    StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('userlist')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Text('No users to check anymore!'
                , textAlign: TextAlign.center);
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    if (isStartup) {
                      if (snapshot.data[index].docs['startup'] == false) {
                        usersList.add(snapshot.data[index]);
                      }
                    }
                    else{
                      if (snapshot.data[index].docs['startup'] == true) {
                        usersList.add(snapshot.data[index]);
                      }
                    }
                    throw{};
                  }
              );
          }
        }
      );
  }
}
