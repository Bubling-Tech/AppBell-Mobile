import 'package:flutter/material.dart';
import 'package:to_com_bell_app/pages/LoginPage.dart';
import 'package:to_com_bell_app/pages/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tô com Bell!',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const Loginpage(),
        // '/home': (context) => const HomePage(),

      },
    );
  }
}

