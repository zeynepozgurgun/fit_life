import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final List<String> goal;
  final int age;
  final int height;
  final int weight;
  final List<String> gender;
  final List<String> preferences;
  final int bmi;

  const User({
    required this.id,
    required this.goal,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.preferences,
    required this.bmi,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      goal: map['goal'] != null ? List<String>.from(map['goal'].cast<String>()) : [],
      age: map['age'] is int ? map['age'] : (map['age'] != null ? int.parse(map['age'].toString()) : 0),
      height: map['height'] is int ? map['height'] : (map['height'] != null ? int.parse(map['height'].toString()) : 0),
      weight: map['weight'] is int ? map['weight'] : (map['weight'] != null ? int.parse(map['weight'].toString()) : 0),
      gender: map['gender'] != null ? List<String>.from(map['gender'].cast<String>()) : [],
      preferences: map['preferences'] != null ? List<String>.from(map['preferences'].cast<String>()) : [],
      bmi: map['bmi'] is int ? map['bmi'] : (map['bmi'] != null ? int.parse(map['bmi'].toString()) : 0),
    );
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot doc) {
    return User.fromMap(doc.data() as Map<String, dynamic>);
  }

  static double calculateBMI(int height, int weight) {
    final double heightInMeters = height / 100.0;
    final double weightInKg = weight.toDouble();
    final double bmi = weightInKg / (heightInMeters * heightInMeters);
    return bmi;
  }

  static Future<void> updateBMI(String userId, int height, int weight) async {
    final double newBmi = calculateBMI(height, weight);
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'height': height,
      'weight': weight,
      'bmi': newBmi.toInt(),
    });
  }
}

