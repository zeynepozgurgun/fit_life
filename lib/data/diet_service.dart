import 'package:cloud_firestore/cloud_firestore.dart';
import 'diet.dart';  

class DietService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Diet>> fetchDiets() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('diets').get();
      return querySnapshot.docs.map((doc) => Diet.fromDocumentSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Error fetching diets: $e');
    }
  }
}
