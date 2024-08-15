import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/data/diet.dart';
import 'package:fit_life/data/user.dart' as FitLifeUser;
import 'package:fit_life/data/diet_service.dart';

mixin DietMixin {
  Future<List<Diet>> loadDiets(
    String userId,
    String searchQuery,
    bool isForYouSelected,
  ) async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final user = FitLifeUser.User.fromDocumentSnapshot(userDoc);

    final allDiets = await DietService().fetchDiets();

    List<Diet> filteredDiets = filterDiets(allDiets, user, isForYouSelected);
    List<Diet> searchedDiets = searchDiets(filteredDiets, searchQuery);

    return searchedDiets;
  }

  List<Diet> filterDiets(List<Diet> diets, FitLifeUser.User user, bool isForYouSelected) {
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