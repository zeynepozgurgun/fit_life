import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/data/diet.dart';
import 'package:fit_life/data/user.dart' as FitLifeUser;
import 'package:fit_life/data/diet_service.dart';
import 'package:flutter/material.dart';
import 'package:fit_life/authentication/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;

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

mixin UserActionsMixin on SnackBarMixin {
  void signOut(BuildContext context) {
    showSnackBar(context, 'Signed out successfully.');

    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    });
  }

  void showWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ColorScheme colorScheme = Theme.of(context).colorScheme;
        return AlertDialog(
          backgroundColor: colorScheme.primary,
          title: Text(
            'Delete Account',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: Theme.of(context).textTheme.headlineSmall),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete my account', style: Theme.of(context).textTheme.headlineSmall),
              onPressed: () {
                deleteAccount(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
                showSnackBar(context, 'Account deleted successfully.');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      final FirebaseAuth.FirebaseAuth auth = FirebaseAuth.FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final FirebaseAuth.User? user = auth.currentUser;

      if (user != null) {
        await firestore.collection('users').doc(user.uid).delete();
        await user.delete();

        signOut(context);
      }
    } catch (e) {
      showSnackBar(context, 'An error occurred: ${e.toString()}');
    }
  }
}
