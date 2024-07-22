// login_page.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fit_life/features/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface, // Turkuaz renk
      body: GestureDetector(
        onTap: () {
          // Klavyeyi kapat
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // Arka plan
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'FİTLİFE',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Welcome!\nswipe up to continue',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    // Burada arka plan görseli yer alacak
                    Image.asset('assets/images/login_image.png', height: 200),
                  ],
                ),
              ),
            ),
            // Login paneli
            DraggableScrollableSheet(
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
                  child: ListView(
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
                                color: colorScheme.secondary, // Farklı renk
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
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: const OutlineInputBorder(),
                          labelStyle: TextStyle(color: colorScheme.onSecondary),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
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
                        onPressed: () {},
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
