import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_life/features/signup_page.dart';
import 'package:image_picker/image_picker.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  final TextEditingController _tEmail = TextEditingController();
  final TextEditingController _tPassword = TextEditingController();

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
            const BackgroundContent(),
            LoginPanel(
              emailController: _tEmail,
              passwordController: _tPassword,
            ),
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
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginPanel({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  Future<void> _login(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Kullanıcı başarılı bir şekilde giriş yaptıktan sonra yönlendirme yapabilirsiniz
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = 'Something went wrong. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

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
            children: [
              const LoginTitle(),
              const SizedBox(height: 10),
              const SignUpLink(),
              const SizedBox(height: 20),
              _inputField(emailController, 'Email', Icons.email),
              const SizedBox(height: 10),
              _inputField(passwordController, 'Password', Icons.lock, obscureText: true),
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
                onPressed: () => _login(context),
              ),
              const ContinueWithoutAccountButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _inputField(TextEditingController controller, String hint, IconData iconData, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(iconData),
        ),
      ),
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
