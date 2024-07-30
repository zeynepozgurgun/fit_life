import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
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
                      'Clickable Text 1',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                onTap: () {
                  
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
                      'Clickable Text 2',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                onTap: () {
                    _showWarning(context);
                  },
              ),
              ),
            ],
          ),
          
          // Image 
          Container(
            padding: EdgeInsets.all(16.0),
            child: Image.asset('assets/your_image.png'), 
          ),
        ],
      ),
    );
  }
}

void _showWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: Text('Are you sure you want to delete your account?'),
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


/*
void main() {
  runApp(MaterialApp(
    home: SettingsScreen(),
  ));
} */
