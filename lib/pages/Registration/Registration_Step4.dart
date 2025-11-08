import 'package:flutter/material.dart';
import 'package:to_com_bell_app/models/User.dart';

class Registration_Step4 extends StatefulWidget {
  final VoidCallback onValidationComplete;
  final User user;

  const Registration_Step4({
    super.key,
    required this.onValidationComplete,
    required this.user,
  });

  @override
  _Registration_Step4State createState() => _Registration_Step4State();
}

class _Registration_Step4State extends State<Registration_Step4> {
  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
  bool isCodeValid = false;

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final String code = controllers.map((c) => c.text).join();
    setState(() {
      isCodeValid = code.length == 6;
    });

    if (isCodeValid) {
      widget.onValidationComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, right: 60),
            child: Text(
              "Valide seu email!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Enviamos um código para o email ${widget.user.email}.Por favor, insira o código abaixo para concluir seu cadastro.",
          ),
          const SizedBox(height: 25),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Digite o código de 6 dígitos",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              return Container(
                width: 50,
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  controller: controllers[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  cursorColor: const Color(0xFF1877F2),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: const Color(0xFFF3F4F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF1877F2), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
                    ),
                  ),
                  onChanged: (_) => _onTextChanged(),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
