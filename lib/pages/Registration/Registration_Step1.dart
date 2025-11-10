import 'package:flutter/material.dart';
import 'package:to_com_bell_app/components/FormField.dart';
import 'package:to_com_bell_app/models/User.dart';

class Registration_Step1 extends StatefulWidget {
  final Function(bool) onValidate;
  final User user;
  final TextEditingController apelidoController;
  final TextEditingController nomeController;
  final TextEditingController sobrenomeController;

  const Registration_Step1({
    super.key,
    required this.onValidate,
    required this.user,
    required this.apelidoController,
    required this.nomeController,
    required this.sobrenomeController,
  });

  @override
  _Registration_Step1State createState() => _Registration_Step1State();
}

class _Registration_Step1State extends State<Registration_Step1> {
  void _validateFields() {
    widget.user.apelido = widget.apelidoController.text;
    widget.user.nome = widget.nomeController.text;
    widget.user.sobrenome = widget.sobrenomeController.text;

    final bool isValid =
        widget.user.apelido!.isNotEmpty && widget.user.nome!.isNotEmpty && widget.user.sobrenome!.isNotEmpty;

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
              "Crie sua conta e entre no universo Bell Marques!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text("Para começar, nos conte um pouco sobre você:"),
            const SizedBox(height: 20),
            FormFieldCustom(
              controller: widget.apelidoController,
              hintText: "Apelido",
              labelText: "Apelido",
              onChanged: (_) => _validateFields(),
            ),
            const SizedBox(height: 10),
            FormFieldCustom(
              controller: widget.nomeController,
              hintText: "Nome",
              labelText: "Nome",
              onChanged: (_) => _validateFields(),
            ),
            const SizedBox(height: 10),
            FormFieldCustom(
              controller: widget.sobrenomeController,
              hintText: "Sobrenome",
              labelText: "Sobrenome",
              onChanged: (_) => _validateFields(),
            ),
          ],
        ),
      ),
    );
  }
}
