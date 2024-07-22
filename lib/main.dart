import 'package:flutter/material.dart';
import 'features/login_page.dart'; // LoginPage'i import ediyoruz
import 'package:fit_life/core/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitlife',
      theme: appTheme, // Özel temamızı burada kullanıyoruz
      home: const LoginPage(), // Ana sayfa olarak LoginPage'i kullanıyoruz
      debugShowCheckedModeBanner: false, // Debug etiketini kaldırıyoruz
    );
  }
}
