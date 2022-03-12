import 'package:flutter/cupertino.dart';
import 'package:fynder/models/startup.dart';
import 'package:fynder/services/database.dart';
import 'package:fynder/services/fire_auth.dart';

class StartupProvider extends ChangeNotifier {
  final String? uid;

  StartupProvider({this.uid});

  final authService = FireAuth();

  String? _name;
  String? _ideaSummary;
  String? _personalLink;
  String? _videoLink;
  String? _targetFunds;
  String? _marketSegment;
  String? _investmentType;
  String? _location;
  String? _pic;

  String? get name => _name;

  String? get ideaSummary => _ideaSummary;

  String? get personalLink => _personalLink;

  String? get videoLink => _videoLink;

  String? get targetFunds => _targetFunds;

  String? get marketSegment => _marketSegment;

  String? get investmentType => _investmentType;

  String? get location => _location;

  String? get pic => _pic;

  set changePic(String? value) {
    _pic = value;
    notifyListeners();
  }

  set changeInvestmentType(String? value) {
    _investmentType = value;
    notifyListeners();
  }

  set changeMarketSegment(String? value) {
    _marketSegment = value;
    notifyListeners();
  }

  set changeTargetFunds(String? value) {
    _targetFunds = value;
    notifyListeners();
  }

  set changeVideoLink(String? value) {
    _videoLink = value;
    notifyListeners();
  }

  set changePersonalLink(String? value) {
    _personalLink = value;
    notifyListeners();
  }

  set changeIdeaSummary(String? value) {
    _ideaSummary = value;
    notifyListeners();
  }

  set changeLocation(String? value) {
    _location = value;
  }

  set changeName(String? value) {
    _name = value;
    notifyListeners();
  }

  saveStartupProfile() {
    var newStartupProfile = Startup(
        name: _name ?? '',
        ideaSummary: _ideaSummary ?? '',
        personalLink: _personalLink ?? '',
        videoLink: _videoLink ?? '',
        targetFunds: _targetFunds ?? '',
        marketSegment: _marketSegment ?? '',
        investmentType: _investmentType ?? '',
        location: _location ?? '',
        pic: _pic ?? '');
    DatabaseService(uid: uid).saveStartupUserDataToFirestore(newStartupProfile);
  }

  updateStartupProfile() {
    var startupProfile = Startup (
        name: _name ?? '',
        ideaSummary: _ideaSummary ?? '',
        personalLink: _personalLink ?? '',
        videoLink: _videoLink ?? '',
        targetFunds: _targetFunds ?? '',
        marketSegment: _marketSegment ?? '',
        investmentType: _investmentType ?? '',
        location: _location ?? '',
        pic: _pic ?? ''
    );
    DatabaseService(uid: uid).updateStartupUserData(startupProfile);
  }
}
