
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_com_bell_app/pages/LoginPage.dart';
import 'package:to_com_bell_app/theme/app_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();


    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginpage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/splash.jpg',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 16),
            const Text(
              'Seja bem-vindo!',
              style: TextStyle(
                fontSize: AppFonts.headingSize,
                fontWeight: AppFonts.bold,
              ),
            ),
            const SizedBox(height: 24),

            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}