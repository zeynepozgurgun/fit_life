import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/data/diet.dart';
import 'package:fit_life/data/user.dart';
import 'package:fit_life/data/diet_service.dart';
import 'package:flutter/material.dart';

mixin DietMixin {
  Future<List<Diet>> loadDiets(
    String userId,
    String searchQuery,
    bool isForYouSelected,
  ) async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final user = User.fromDocumentSnapshot(userDoc);

    final allDiets = await DietService().fetchDiets();

    List<Diet> filteredDiets = filterDiets(allDiets, user, isForYouSelected);
    List<Diet> searchedDiets = searchDiets(filteredDiets, searchQuery);

    return searchedDiets;
  }

  List<Diet> filterDiets(List<Diet> diets, User user, bool isForYouSelected) {
    return diets.where((diet) {
      bool goalsMatch = diet.goals.isEmpty || diet.goals.any((goal) => user.goal.contains(goal));
      bool preferencesMatch = diet.preferences.isEmpty || diet.preferences.any((preference) => user.preferences.contains(preference));
      bool ageMatch = user.age == 0 || (user.age >= diet.ageRange[0] && user.age <= diet.ageRange[1]);
      bool bmiMatch = user.bmi == 0 || (user.bmi >= diet.bmi[0] && user.bmi <= diet.bmi[1]);

      return isForYouSelected ? goalsMatch && preferencesMatch && ageMatch && bmiMatch : true;
    }).toList();
  }

  List<Diet> searchDiets(List<Diet> diets, String query) {
    return diets.where((diet) => diet.title.toLowerCase().contains(query.toLowerCase())).toList();
  }
}

mixin SnackBarMixin {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onError,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),
    );
  }
}
