class Startup {
  final String name;
  final String ideaSummary;
  final String personalLink;
  final String videoLink;
  final String targetFunds;
  final String marketSegment;
  final String investmentType;
  final String pic;

  Startup(
      {required this.name,
      required this.ideaSummary,
      required this.personalLink,
      required this.videoLink,
      required this.targetFunds,
      required this.marketSegment,
      required this.investmentType,
      required this.pic});

  // send data to Firestore
  Map<String, dynamic> toMap() {
    return {
      'ideaSummary': ideaSummary,
      'personalLink': personalLink,
      'videoLink': videoLink,
      'targetFunds': targetFunds,
      'marketSegment': marketSegment,
      'investmentType': investmentType,
      'picture': pic,
      'name': name,
      'investor': false,
      'startup': true
    };
  }

  // retrieve data from firestore
  factory Startup.fromFirestore(Map<String, dynamic> firestore) => Startup(
      name: firestore['name'],
      ideaSummary: firestore['ideaSummary'],
      personalLink: firestore['personalLink'],
      videoLink: firestore['videoLink'],
      targetFunds: firestore['targetFunds'],
      marketSegment: firestore['marketSegment'],
      investmentType: firestore['investmentType'],
      pic: firestore['picture']);
}
