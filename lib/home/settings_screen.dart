import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/authentication/login_page.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 120.0),
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          
          const SizedBox(height: 40),

          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text(
                    'Sign out',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () {
                    _signOut(context);
                  },
                ),
              ),

              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0),
                child: Divider(
                  height: 1.0,
                  thickness: 1.0,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text(
                    'Delete Account',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () {
                    _showWarning(context);
                  },
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(16.0),
            child: Image.asset('assets/images/settingsimg.png', height: 300, width: 300), 
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) {
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
              'Signed out successfully.',
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

    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    });
  }

  void _showWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete my account'),
              onPressed: () {
                _deleteAccount(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage(),
                ));
                
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
                'Account deleted successfully.',
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
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final User? user = auth.currentUser;

      if (user != null) {
        // delete user document from Firestore
        await firestore.collection('users').doc(user.uid).delete();
        await user.delete();

        _signOut(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
