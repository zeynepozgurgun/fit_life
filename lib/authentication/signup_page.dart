import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/authentication/login_page.dart';
import 'package:fit_life/methods/snack_bar_mixin.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SnackBarMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 10.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, size: 45.0),
            color: colorScheme.onSecondary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign up:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 20),
              Text(
                'Email:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffCBDBCD),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _emailController,
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffCBDBCD),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final String email = _emailController.text;
                    final String password = _passwordController.text;

                    final RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (!emailRegExp.hasMatch(email)) {
                      showSnackBar(context, 'Please enter a valid email address.');
                      return;
                    }

                    if (password.length < 6) {
                      showSnackBar(context, 'Password must be at least 6 characters long.');
                      return;
                    }

                    try {
                      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      User? user = userCredential.user;

                      if (user != null) {
                        await _firestore.collection('users').doc(user.uid).set({
                          'id': user.uid,
                          'goal': '',
                          'age': 0,
                          'height': 0.0,
                          'weight': 0.0,
                          'gender': '',
                          'preferences': '',
                        });
                      }

                      showSnackBar(context, 'Successfully created account.');

                      await Future.delayed(Duration(seconds: 2));

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'email-already-in-use') {
                        showSnackBar(context, 'The email address is already in use.');
                      } else {
                        showSnackBar(context, 'An error occurred: ${e.message}');
                      }
                    }
                  },
                  child: Text('Create Account'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.onSecondary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
