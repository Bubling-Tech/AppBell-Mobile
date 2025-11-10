import 'package:flutter/material.dart';
import 'package:to_com_bell_app/components/DropdownCustom.dart';
import 'package:to_com_bell_app/components/FormField.dart';
import 'package:to_com_bell_app/models/User.dart';
import 'package:to_com_bell_app/services/LocationService.dart';

class Registration_Step2 extends StatefulWidget {
  final Function(bool) onValidate;
  final User user;
  final TextEditingController emailController;

  const Registration_Step2({
    super.key,
    required this.onValidate,
    required this.user,
    required this.emailController,
  });

  @override
  _Registration_Step2State createState() => _Registration_Step2State();
}

class _Registration_Step2State extends State<Registration_Step2> {
  final LocationService locationService = LocationService();

  List<Map<String, dynamic>> estados = [];
  List<Map<String, dynamic>> cidades = [];

  String? estadoSelecionado;
  String? cidadeSelecionada;

  @override
  void initState() {
    super.initState();
    carregarEstados();
  }

  Future<void> carregarEstados() async {
    try {
      final List<Map<String, dynamic>> estadosCarregados = await locationService.fetchStates();
      setState(() {
        estados = estadosCarregados;
        if (widget.user.estadoId != null) {
          estadoSelecionado = estados
              .firstWhere((e) => e["id"] == widget.user.estadoId, orElse: () => {"nome": null})["nome"];
        } else {
          estadoSelecionado = estados.isNotEmpty ? estados.first["nome"] : null;
        }
        if (estadoSelecionado != null) {
          final int estadoId = estados.firstWhere((e) => e["nome"] == estadoSelecionado)["id"];
          carregarCidades(estadoId);
        }
      });
      _validateFields();
    } catch (e) {
      debugPrint("Erro ao carregar estados: $e");
    }
  }

  Future<void> carregarCidades(int estadoId) async {
    try {
      final List<Map<String, dynamic>> cidadesCarregadas = await locationService.fetchCities(estadoId);
      setState(() {
        cidades = cidadesCarregadas;
        if (widget.user.cidadeId != null && cidades.any((c) => c["id"] == widget.user.cidadeId)) {
          cidadeSelecionada = cidades
              .firstWhere((c) => c["id"] == widget.user.cidadeId, orElse: () => {"nome": null})["nome"];
        } else {
          cidadeSelecionada = cidades.isNotEmpty ? cidades.first["nome"] : null;
        }
      });
      _validateFields();
    } catch (e) {
      debugPrint("Erro ao carregar cidades: $e");
    }
  }

  void _validateFields() {
    if (estados.isEmpty || cidades.isEmpty) return;

    widget.user.email = widget.emailController.text;
    widget.user.estadoId = estados
        .firstWhere((e) => e["nome"] == estadoSelecionado, orElse: () => {"id": null})["id"];

    widget.user.cidadeId = cidades
        .firstWhere((c) => c["nome"] == cidadeSelecionada, orElse: () => {"id": null})["id"];

    final bool isValid =
        widget.user.email!.isNotEmpty && widget.user.estadoId != null && widget.user.cidadeId != null;

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
            const Padding(
              padding: EdgeInsets.only(top: 20, right: 60),
              child: Text(
                "Crie sua conta e entre no universo Bell Marques!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Para começar, nos conte um pouco sobre você:"),
            const SizedBox(height: 20),
            FormFieldCustom(
              controller: widget.emailController,
              hintText: "Ex: meu-email@email.com",
              labelText: "Email",
              onChanged: (_) => _validateFields(),
            ),
            const SizedBox(height: 10),
            estados.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : DropdownCustom(
                    items: estados.map((e) => e["nome"].toString()).toList(),
                    onChanged: (value) {
                      setState(() {
                        estadoSelecionado = value;
                        cidadeSelecionada = null;
                        cidades = [];
                      });
                      final int estadoId = estados.firstWhere((e) => e["nome"] == value)["id"];
                      carregarCidades(estadoId);
                    },
                    labelText: "Estado",
                    initialValue: estadoSelecionado,
                  ),
            const SizedBox(height: 10),
            cidades.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : DropdownCustom(
                    items: cidades.map((c) => c["nome"].toString()).toList(),
                    onChanged: (value) {
                      setState(() {
                        cidadeSelecionada = value;
                      });
                      _validateFields();
                    },
                    labelText: "Cidade",
                    initialValue: cidades.any((c) => c["nome"] == cidadeSelecionada) ? cidadeSelecionada : null,
                  ),
          ],
        ),
      ),
    );
  }
}
