import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class User {
  final String id;
  final List<String> goal;
  final String age;
  final String height;
  final String weight;
  final List<String> gender;
  final List<String> preferences;

  const User({
    required this.id,
    required this.goal,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.preferences,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      goal: List<String>.from(map['goal']),
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
      gender: List<String>.from(map['gender']),
      preferences: List<String>.from(map['preferences']),
    );
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot doc) {
    return User.fromMap(doc.data() as Map<String, dynamic>);
  }
}
