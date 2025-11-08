
import 'package:flutter/material.dart';
import 'package:to_com_bell_app/components/ButtonLarge.dart';
import 'package:to_com_bell_app/components/FormField.dart';
import 'package:to_com_bell_app/pages/Registration/RegistrationScreen.dart';
import 'package:to_com_bell_app/theme/app_fonts.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _login() {
    String email = _emailController.text;
    print("Email: $email");
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormFieldCustom(controller: _emailController, hintText: "Número de telefone, e-mail ou nome de usuário", isPassword: false),
                SizedBox(height: 15),
                FormFieldCustom(controller: _senhaController, hintText: "Senha", isPassword: true),
                SizedBox(height: 15),
                ButtonLarge(onPressed: _login, text: "Entrar", gradientColors: [
                  Color(0xFFFF5125),
                  Color(0xFFFF135E),
                ],),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Não tem uma conta? ", style: TextStyle(fontWeight: AppFonts.normal, fontSize: 12)),
                    GestureDetector(
                      onTap: ()=> Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                      ),
                      child: Text("Clique aqui", style: TextStyle(color: Colors.blue, fontWeight: AppFonts.normal, fontSize: 12),),

                    )
                  ],
                )
              ],
            ),),
      ),
    );
  }
}
