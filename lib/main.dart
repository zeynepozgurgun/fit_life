import 'package:flutter/material.dart';
import 'package:fit_life/core/theme.dart';
import 'package:fit_life/features/login_page.dart';
import 'package:fit_life/features/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
      title: 'FitLife',
      theme: appTheme,
      home: LoginPage(),
=======
      title: 'Fitlife',
      theme: appTheme, // Özel temamızı burada kullanıyoruz
      home: const LoginPage(), // Ana sayfa olarak LoginPage'i kullanıyoruz
      debugShowCheckedModeBanner: false, // Debug etiketini kaldırıyoruz
>>>>>>> Stashed changes
    );
  }
}

