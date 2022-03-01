import 'package:flutter/cupertino.dart';

import '../models/investor.dart';
import '../services/database.dart';
import '../services/fire_auth.dart';

class InvestorProvider extends ChangeNotifier {
  final databaseService = DatabaseService();
  final authService = FireAuth();

  String? _name;
  String? _description;
  String? _personalLink;
  String? _videoLink;
  String? _pic;

  String? get name => _name;

  String? get description => _description;

  String? get personalLink => _personalLink;

  String? get videoLink => _videoLink;

  String? get pic => _pic;

  set changePic(String value) {
    _pic = value;
  }

  set changeVideoLink(String value) {
    _videoLink = value;
  }

  set changePersonalLink(String value) {
    _personalLink = value;
  }

  set changeDescription(String value) {
    _description = value;
  }

  set changeName(String value) {
    _name = value;
  }

  saveInvestorProfile() {
    var newInvestorProfile = Investor(
        name: _name ?? '',
        description: _description ?? '',
        personalLink: _personalLink ?? '',
        videoLink: _videoLink ?? '',
        pic: _pic ?? '');
    databaseService.saveInvestorUserDataToFirestore(newInvestorProfile);
  }
}
