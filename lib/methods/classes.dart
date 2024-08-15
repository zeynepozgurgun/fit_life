import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_life/authentication/signup_page.dart';
import 'package:fit_life/home/base.dart';



class SlidingPanel extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(String) showSnackBar; // Callback for showing snack bars

  SlidingPanel(this.emailController, this.passwordController, {required this.showSnackBar});

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
                        showSnackBar('Wrong credentials. Try again or sign up if you don\'t have an account.');
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


class InputFieldRow extends StatelessWidget {
  const InputFieldRow({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
             child: child
          )
        ],
      ),
    );
  }
}