import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/authentication/login_page.dart';
import 'package:fit_life/methods/mixins.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SnackBarMixin {
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
    showSnackBar(context, 'Signed out successfully.');

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
                
                showSnackBar(context, 'Account deleted successfully.');
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
      showSnackBar(context, 'An error occurred: ${e.toString()}');
    }
  }
}
