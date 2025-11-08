import 'package:flutter/material.dart';
import 'package:to_com_bell_app/components/ButtonSmall.dart';
import 'package:to_com_bell_app/pages/LoginPage.dart';

class SuccessRegistrationScreen extends StatelessWidget {
  const SuccessRegistrationScreen({super.key});

  void _goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Loginpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "lib/assets/images/splash.jpg",
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Cadastro realizado com sucesso!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Agora você pode acessar sua conta e aproveitar todos os benefícios do nosso app!",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ButtonSmall(
              onPressed: () => _goToLogin(context),
              text: "Ir para o login",
              gradientColors: const [
                Color(0xFFFF5125),
                Color(0xFFFF135E),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
