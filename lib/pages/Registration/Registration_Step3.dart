import 'package:flutter/material.dart';
import 'package:to_com_bell_app/components/FormField.dart';

import '../../models/User.dart';

class Registration_Step3 extends StatefulWidget {
  final Function(bool) onValidate;
  final User user;
  final TextEditingController senhaController;
  final TextEditingController confirmarSenhaController;

  const Registration_Step3({
    super.key,
    required this.onValidate,
    required this.user,
    required this.senhaController,
    required this.confirmarSenhaController,
  });

  @override
  _Registration_Step3State createState() => _Registration_Step3State();
}

class _Registration_Step3State extends State<Registration_Step3> {

  void _validateFields() {
    // Atualiza os valores no objeto User
    widget.user.senha = widget.senhaController.text;

    // Validação para verificar se os campos estão preenchidos e as senhas são iguais
    bool isValid = widget.user.senha!.isNotEmpty &&
        widget.senhaController.text.isNotEmpty &&
        widget.confirmarSenhaController.text.isNotEmpty &&
        widget.senhaController.text == widget.confirmarSenhaController.text;

    widget.onValidate(isValid);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Crie sua senha de segurança:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            FormFieldCustom(
              controller: widget.senhaController,
              hintText: "Senha",
              labelText: "Senha",
              isPassword: true,
              onChanged: (_) => _validateFields(),
            ),
            const SizedBox(height: 10),
            FormFieldCustom(
              controller: widget.confirmarSenhaController,
              hintText: "Confirmar Senha",
              labelText: "Confirmar Senha",
              isPassword: true,
              onChanged: (_) => _validateFields(),
            ),
          ],
        ),
      ),
    );
  }
}
