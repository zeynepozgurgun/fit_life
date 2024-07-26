import 'package:flutter/material.dart';
import 'navigation_bar.dart';
import 'settings_screen.dart';
import 'browse_screen.dart';
import 'my_account.dart';

class BaseScreen extends StatefulWidget { //sstateful because it needs to remember which screen is currently active
  @override
  _BaseScreenState createState() => _BaseScreenState(); //STATE OBJECT. createState is required for all stateful w.s
}

class _BaseScreenState extends State<BaseScreen> { //it ties this state to the BaseScreen widget,
                                                  //allowing it to manage and update the UI based on
                                                  //user interactions.
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    MyAccount(),
    BrowseScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
