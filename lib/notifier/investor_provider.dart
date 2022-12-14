import 'package:flutter/cupertino.dart';

import '../models/investor.dart';
import '../services/database.dart';
import '../services/fire_auth.dart';

class InvestorProvider extends ChangeNotifier {
  final String? uid;

  InvestorProvider({this.uid});

  final authService = FireAuth();

  String? _name;
  String? _description;
  String? _personalLink;
  String? _videoLink;
  String? _location;
  String? _pic;
  String? _id;

  String? get name => _name;

  String? get description => _description;

  String? get personalLink => _personalLink;

  String? get videoLink => _videoLink;

  String? get location => _location;

  String? get pic => _pic;

  String? get id => _id;

  set changePic(String? value) {
    _pic = value;
  }

  set changeVideoLink(String? value) {
    _videoLink = value;
  }

  set changePersonalLink(String? value) {
    _personalLink = value;
  }

  set changeDescription(String? value) {
    _description = value;
  }

  set changeLocation(String? value) {
    _location = value;
  }

  set changeName(String? value) {
    _name = value;
  }

  set changeUid(String? value) {
    _id = value;
  }

  saveInvestorProfile() {
    var newInvestorProfile = Investor(
        name: _name ?? '',
        description: _description ?? '',
        personalLink: _personalLink ?? '',
        videoLink: _videoLink ?? '',
        location: _location ?? '',
        pic: _pic ?? '',
        id: _id ?? '');
    DatabaseService(uid: uid).updateInvestorUserData(newInvestorProfile);
  }

  updateInvestorProfile() {
    var investorProfile = Investor(
        name: _name ?? '',
        description: _description ?? '',
        personalLink: _personalLink ?? '',
        videoLink: _videoLink ?? '',
        location: _location ?? '',
        pic: _pic ?? '',
        id: _id ?? '');
    DatabaseService(uid: uid).updateInvestorUserData(investorProfile);
  }
}
