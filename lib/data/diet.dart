import 'package:cloud_firestore/cloud_firestore.dart';

class Diet {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final List<String> whatToEat;
  final List<String> whatToAvoid;
  final List<String> whoShouldAvoid;

  // for filtering
  final List<int> ageRange; // Changed to List<int>
  final List<int> bmi;      // Changed to List<int>
  final List<String> genders;
  final List<String> goals;
  final List<String> preferences;

  const Diet({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.whatToEat,
    required this.whatToAvoid,
    required this.whoShouldAvoid,
    required this.ageRange,
    required this.bmi,
    required this.genders,
    required this.goals,
    required this.preferences,
  });

  factory Diet.fromMap(Map<String, dynamic> map) {
    List<int> _convertToIntList(List<dynamic>? list) {
      if (list == null) return [];
      return list.map((e) => e is int ? e : int.tryParse(e.toString()) ?? 0).toList();
    }

    List<String> _convertToStringList(List<dynamic>? list) {
      if (list == null) return [];
      return list.map((e) => e.toString()).toList();
    }

    return Diet(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      whatToEat: _convertToStringList(map['whatToEat']),
      whatToAvoid: _convertToStringList(map['whatToAvoid']),
      whoShouldAvoid: _convertToStringList(map['whoShouldAvoid']),
      ageRange: _convertToIntList(map['ageRange']),
      bmi: _convertToIntList(map['bmi']),
      genders: _convertToStringList(map['genders']),
      goals: _convertToStringList(map['goals']),
      preferences: _convertToStringList(map['preferences']),
    );
  }

  factory Diet.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Diet.fromMap(doc.data() as Map<String, dynamic>);
  }
}
