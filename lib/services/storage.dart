import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Storage {
  final FirebaseStorage storage =
      FirebaseStorage.instance;
  late final BuildContext context;

  Future <String> getURL (String fileName) async {
    var fileURL = await storage.ref().child(fileName).getDownloadURL();
    return fileURL;
  }

  Future <void> uplaodFile (String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref(fileName).putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not upload Picture. Please try again.')
        ),
      );
    }
  }
}