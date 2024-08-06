import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_life/authentication/login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

                    void showSnackBar(String message) {
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

                    final RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (!emailRegExp.hasMatch(email)) {
                      showSnackBar('Please enter a valid email address.');
                      return;
                    }

      
                    if (password.length < 6) {
                      showSnackBar('Password must be at least 6 characters long.');
                      return;
                    }

                    try {
                      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      showSnackBar('Successfully created account.');

                    
                      await Future.delayed(Duration(seconds: 2));

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'email-already-in-use') {
                        showSnackBar('The email address is already in use.');
                      } else {
                        showSnackBar('An error occurred: ${e.message}');
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