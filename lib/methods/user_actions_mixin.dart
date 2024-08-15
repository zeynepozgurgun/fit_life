import 'package:flutter/material.dart';
import 'package:fit_life/authentication/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:fit_life/methods/snack_bar_mixin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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