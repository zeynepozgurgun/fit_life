import 'package:flutter/material.dart';
import 'package:fit_life/methods/user_actions_mixin.dart';
import 'package:fit_life/methods/snack_bar_mixin.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SnackBarMixin, UserActionsMixin {
  @override
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
                    'Sign out',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () {
                    signOut(context);
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
                    'Delete Account',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () {
                    showWarning(context);
                  },
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(16.0),
            child: Image.asset('assets/images/settings2.png', height: 300, width: 300), 
          ),
        ],
      ),
    );
  }
}
