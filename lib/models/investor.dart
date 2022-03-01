class Investor {
  final String name;
  final String description;
  final String personalLink;
  final String videoLink;
  final String pic;

  Investor(
      {required this.name,
      required this.description,
      required this.personalLink,
      required this.videoLink,
      required this.pic});

  // send data to Firestore
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'personalLink': personalLink,
      'videoLink': videoLink,
      'picture': pic,
      'name': name,
      'investor': true,
      'startup': false
    };
  }

  // retrieve data from firestore
  factory Investor.fromFirestore(Map<String, dynamic> firestore) => Investor(
      name: firestore['name'],
      description: firestore['description'],
      personalLink: firestore['personalLink'],
      videoLink: firestore['videoLink'],
      pic: firestore['picture']);
}
