import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late final BuildContext context;

  Future <void> uplaodFile (String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not upload Picture. Please try again.')
        ),
      );
    }
  }
}