import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(Icons.account_circle),
          ),
          label: 'Account',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 4.0), 
            child: Icon(Icons.search),
          ),
          label: 'Browse',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 4.0), 
            child: Icon(Icons.settings),
          ),
          label: 'Settings',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/account');
            break;
          case 1:
            Navigator.pushNamed(context, '/browse');
            break;
          case 2:
            Navigator.pushNamed(context, '/settings');
            break;
        }
      },
      backgroundColor: colorScheme.primary,
      selectedItemColor: colorScheme.secondary,
      unselectedItemColor: colorScheme.onSecondary,
    );
  }
}
