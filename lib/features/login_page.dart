import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fit_life/features/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const Stack(
          children: [
            BackgroundContent(),
            LoginPanel(),
          ],
        ),
      ),
    );
  }
}
class BackgroundContent extends StatelessWidget {
  const BackgroundContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
          Image.asset('assets/images/login_image.png', height: 200),
        ],
      ),
    );
  }
}
class LoginPanel extends StatelessWidget {
  const LoginPanel({super.key});

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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: controller,
            children: const [
              LoginTitle(),
              SizedBox(height: 10),
              SignUpLink(),
              SizedBox(height: 20),
              UsernameTextField(),
              SizedBox(height: 10),
              PasswordTextField(),
              SizedBox(height: 20),
              LoginButton(),
              ContinueWithoutAccountButton(),
            ],
          ),
        );
      },
    );
  }
}
class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Log In:',
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return RichText(
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
    );
  }
}
class UsernameTextField extends StatelessWidget {
  const UsernameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextField(
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        labelText: 'Username',
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: colorScheme.onSecondary),
      ),
    );
  }
}
class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextField(
      obscureText: true,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        labelText: 'Password',
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: colorScheme.onSecondary),
      ),
    );
  }
}
class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
      ),
      child: Text(
        'Log in',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
      ),
      onPressed: () {},
    );
  }
}
class ContinueWithoutAccountButton extends StatelessWidget {
  const ContinueWithoutAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        'Continue without an account',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onPressed: () {},
    );
  }
}
