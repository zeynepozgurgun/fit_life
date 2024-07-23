
import 'package:flutter/material.dart';
import 'package:fit_life/core/theme.dart'; // appTheme'i import ediyoruz
import 'features/login_page.dart'; // LoginPage'i import ediyoruz
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'features/my_account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
