import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fit_life/authentication/login_page.dart';
import 'package:fit_life/authentication/signup_page.dart';

class NoAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle,
                size: 100,
                color: colorScheme.onSecondary,
              ),
              SizedBox(height: 20),
              Text(
                "You have not signed up to an account yet.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineSmall,
                  children: [
                    TextSpan(
                      text: "Sign up",
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage()),
                          );
                        },
                    ),
                    TextSpan(text: " or "),
                    TextSpan(
                      text: "log in",
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                    ),
                    TextSpan(text: " to an account to see personalized suggestions."),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
