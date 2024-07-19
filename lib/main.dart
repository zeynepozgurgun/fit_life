import 'package:flutter/material.dart';
import 'login_page.dart'; // LoginPage'i import ediyoruz

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitlife',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Uygulamanın ana rengini teal olarak ayarlıyoruz
        fontFamily: 'Roboto', // Varsayılan font ailesini Roboto olarak ayarlıyoruz
      ),
      home: const LoginPage(), // Ana sayfa olarak LoginPage'i kullanıyoruz
      debugShowCheckedModeBanner: false, // Debug etiketini kaldırıyoruz
    );
  }
}