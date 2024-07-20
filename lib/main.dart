import 'package:flutter/material.dart';
import 'package:fit_life/core/theme.dart';
import 'package:fit_life/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitlife',
      theme:appTheme,
      home: const LoginPage(), // Ana sayfa olarak LoginPage'i kullanıyoruz
      debugShowCheckedModeBanner: false, // Debug etiketini kaldırıyoruz
    );
  }
}

