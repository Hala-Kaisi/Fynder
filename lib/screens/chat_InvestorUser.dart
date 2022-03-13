import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fynder/services/database.dart';
import 'package:fynder/services/storage.dart';
import 'package:fynder/shared/actions_menu.dart';
import 'package:fynder/shared/menu_drawer.dart';
import 'package:fynder/shared/menu_bottom.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/services.dart';

import '../models/investor.dart';
import '../models/startup.dart';

final _firestore = FirebaseFirestore.instance;
Startup? loggedInuser;
Investor? chatUser;
final focusNode = FocusNode();
String? chatRoomID;
String? userName;
String? chatUserName;

class ChatScreenInvestor extends StatefulWidget {
  Startup user;
  Investor chatUser;

  ChatScreenInvestor({required this.user, required this.chatUser});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenInvestor> {
  final controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  var messageText;
  late Startup user;
  late Investor chatUser;

  @override
  void initState() {
    super.initState();
    this.user = widget.user;
    this.chatUser = widget.chatUser;
    chatUser = widget.chatUser;
    loggedInuser = widget.user;
    chatRoomID = '${user.name}+${chatUser.name}';
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
      setState(() {
        this.isKeyboardVisible = isKeyboardVisible;
      });

      if (isKeyboardVisible && isEmojiVisible) {
        setState(() {
          isEmojiVisible = false;
        });
      }
    });
  }

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  Future<bool> onBackPress() {
    if (isEmojiVisible) {
      toggleEmojiKeyboard();
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  void dispose() async {
    super.dispose();
    await _auth.signOut();
  }

  void onEmojiSelected(String emoji) => setState(() {
    controller.text = controller.text + emoji;
  });

  @override
  Widget build(BuildContext context) {
    chatUserName = chatUser.name;
    Widget buildSticker() {
      return EmojiPicker(
        onEmojiSelected: (emoji, category) {
          onEmojiSelected(category.emoji);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('$chatUserName', style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onBackPress,
          child: SingleChildScrollView( child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                padding: EdgeInsets.only(left: 20),
                width: double.infinity,
                height: 60.0,
                decoration: const BoxDecoration(
                    border: Border(
                        top:
                        BorderSide(color: Colors.blueGrey, width: 0.5)),
                    color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /*Material(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: IconButton(
                          icon: Icon(isEmojiVisible
                              ? Icons.keyboard_rounded
                              : Icons.emoji_emotions),
                          onPressed: onClickedEmoji,
                          color: Colors.blue,
                        ),
                      ),
                      color: Colors.white,
                    ),*/
                    Flexible(
                      child: Container(
                        height: 40,
                        child: TextField(
                          cursorColor: Colors.blue,
                          cursorHeight: 20,
                          textInputAction: TextInputAction.send,
                          keyboardType: TextInputType.multiline,
                          focusNode: focusNode,
                          onSubmitted: (value) {
                            controller.clear();
                            _firestore.collection('chats').doc(chatRoomID).collection('messages').add({
                              'sender': user.name,
                              'text': messageText,
                              'timestamp': Timestamp.now(),
                            });
                          },
                          maxLines: null,
                          controller: controller,
                          onChanged: (value) {
                            messageText = value;
                          },
                          style:
                          const TextStyle(color: Colors.blueGrey, fontSize: 17.0),
                          decoration: const InputDecoration(
                            hintText: 'Type Something...',
                            hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 12, height: 2),
                            contentPadding: EdgeInsets.only(top: 7, bottom: 7, left: 15, right: 15)
                          ),
                        ),
                      ),
                    ),
                    Material(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.blue),
                          onPressed: () {
                            controller.clear();
                            _firestore.collection('chats').doc(chatRoomID).collection('messages').add({
                              'sender': user.name,
                              'text': messageText,
                              'timestamp': Timestamp.now(),
                            });
                          },
                          color: Colors.blueGrey,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              (isEmojiVisible ? buildSticker() : Container()),
            ],
          ),
          ),
        ),
      ),
    );
  }

  void onClickedEmoji() async {
    if (isEmojiVisible) {
      focusNode.requestFocus();
    } else if (isKeyboardVisible) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(const Duration(milliseconds: 100));
    }
    toggleEmojiKeyboard();
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('chats').doc(chatRoomID).collection('messages')
      // Sort the messages by timestamp DESC because we want the newest messages on bottom.
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        // If we do not have data yet, show a progress indicator.
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // Create the list of message widgets.

        //final messages = snapshot.data?.docs.reversed;
        return Container(
          height: 620,
          child: ListView.builder(
            reverse: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index){
                return MessageBubble(
                  sender: snapshot.data?.docs[index]['sender'],
                  text: snapshot.data?.docs[index]['text'],
                  timestamp: snapshot.data?.docs[index]['timestamp'],
                  isMe: loggedInuser?.name == snapshot.data?.docs[index]['sender'],
                );
              }),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.timestamp, this.isMe});
  final String? sender;
  final String? text;
  final Timestamp? timestamp;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    final dateTime =
    DateTime.fromMillisecondsSinceEpoch(timestamp!.seconds * 1000);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$sender",
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          SizedBox(height: 5,),
          Material(
            borderRadius: isMe!
                ? BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            )
                : BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color:
            isMe! ? Colors.lightBlue[300] : Colors.lightBlue[600],
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment:
                isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    text!,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: isMe! ? Colors.white : Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      "${DateFormat('h:mm a').format(dateTime)}",
                      style: TextStyle(
                        fontSize: 9.0,
                        color: isMe!
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black54.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}