<<<<<<< Updated upstream
import 'package:flutter/material.dart';
import 'login_page.dart'; // LoginPage'i import ediyoruz
import 'package:fit_life/core/theme.dart';
import 'package:fit_life/features/login_page.dart';
import 'package:fit_life/features/signup_page.dart';
=======

import 'package:flutter/material.dart';
import 'package:fit_life/core/theme.dart'; // appTheme'i import ediyoruz
import 'login_page.dart'; // LoginPage'i import ediyoruz
>>>>>>> Stashed changes

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitlife',
<<<<<<< Updated upstream
      theme: ThemeData(
        primarySwatch: Colors.teal, // Uygulamanın ana rengini teal olarak ayarlıyoruz
        fontFamily: 'Roboto', // Varsayılan font ailesini Roboto olarak ayarlıyoruz
      ),
=======
      theme: appTheme, // Özel temamızı burada kullanıyoruz
>>>>>>> Stashed changes
      home: const LoginPage(), // Ana sayfa olarak LoginPage'i kullanıyoruz
      debugShowCheckedModeBanner: false, // Debug etiketini kaldırıyoruz
    );
  }
}
