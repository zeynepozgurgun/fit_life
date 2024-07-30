import 'package:cloud_firestore/cloud_firestore.dart';

class Diet {
  final String title;
  final String imageUrl;
  final String description;
  final List<String> whatToEat;
  final List<String> whatToAvoid;
  final List<String> whoShouldAvoid;

  const Diet({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.whatToEat,
    required this.whatToAvoid,
    required this.whoShouldAvoid,
  });

  factory Diet.fromMap(Map<String, dynamic> map) {
    return Diet(
      title: map['title'],
      imageUrl: map['imageUrl'],
      description: map['description'],
      whatToEat: List<String>.from(map['whatToEat']),
      whatToAvoid: List<String>.from(map['whatToAvoid']),
      whoShouldAvoid: List<String>.from(map['whoShouldAvoid']),
    );
  }

  factory Diet.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Diet.fromMap(doc.data() as Map<String, dynamic>);
  }
}
