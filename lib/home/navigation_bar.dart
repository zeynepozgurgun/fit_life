import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

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
      currentIndex: currentIndex, 
      onTap: onTap, 
      backgroundColor: colorScheme.primary,
      selectedItemColor: colorScheme.secondary,
      unselectedItemColor: colorScheme.onSecondary,
    );
  }
}
