import 'package:flutter/material.dart';
import 'package:fit_life/core/theme.dart';
import 'package:fit_life/features/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitLife',
      theme: appTheme,
      home: LoginPage(),
    );
  }
}

