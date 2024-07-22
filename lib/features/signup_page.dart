import 'package:flutter/material.dart';
import 'package:fit_life/login_page.dart';

class SignupPage extends StatelessWidget {
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
                'Username:',
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
                  obscureText: true,
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center( // Center the button
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
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
