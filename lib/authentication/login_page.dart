import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_life/authentication/signup_page.dart';
import 'package:fit_life/home/base.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Center(
  child: Padding(
    padding: const EdgeInsets.only(bottom: 150.0), 
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'FIT-LIFE',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Text(
          'Welcome!\nswipe up to continue',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 20),
        Image.asset('assets/images/login_image.png', height: 300, width: 400),
      ],
    ),
  ),
),

            SlidingPanel(_emailController, _passwordController),
          ],
        ),
      ),
    );
  }
}

class SlidingPanel extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  SlidingPanel(this.emailController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.35,
      maxChildSize: 0.85,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Icon(
                Icons.keyboard_arrow_up,
                color: colorScheme.onSecondary,
                size: 24,
              ),
              ListView(
                controller: controller,
                children: [
                  Text(
                    'Log In:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.headlineSmall,
                      children: [
                        TextSpan(
                          text: 'Sign up here.',
                          style: TextStyle(
                            color: colorScheme.secondary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    style: Theme.of(context).textTheme.titleSmall,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(color: colorScheme.onSecondary),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: Theme.of(context).textTheme.titleSmall,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(color: colorScheme.onSecondary),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.secondary,
                      foregroundColor: colorScheme.onSecondary,
                    ),
                    child: Text(
                      'Log in',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                    ),
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => BaseScreen()),
                        );
                      } on FirebaseAuthException catch (e) {
                        print('Failed with error code: ${e.code}');
                        print(e.message);
                        
                        // LOGIN FAILURE
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
          'Wrong credentials. Try again or sign up if you don\'t have an account.',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center, // Ensure text alignment is center
        ),
      ),
      ),
      backgroundColor: Colors.transparent, 
      behavior: SnackBarBehavior.floating,
      elevation: 0, 
                          ),
                        );
                      }
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Continue without an account',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
