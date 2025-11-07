import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_gradients.dart';
import 'package:to_com_bell_app/features/eventos/models/filtro_evento.dart';

class FiltroBottomSheet extends StatefulWidget {
  const FiltroBottomSheet({super.key, required this.filtroAtual});

  final FiltroEvento filtroAtual;

  static Future<FiltroEvento?> show(
    BuildContext context, {
    required FiltroEvento filtroAtual,
  }) {
    return showModalBottomSheet<FiltroEvento>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => FiltroBottomSheet(filtroAtual: filtroAtual),
    );
  }

  @override
  State<FiltroBottomSheet> createState() => _FiltroBottomSheetState();
}

class _FiltroBottomSheetState extends State<FiltroBottomSheet> {
  static const List<String> ufs = ['BA', 'PE', 'SE'];
  static const Map<int, String> meses = {
    1: 'Janeiro',
    2: 'Fevereiro',
    3: 'Março',
    4: 'Abril',
    5: 'Maio',
    6: 'Junho',
    7: 'Julho',
    8: 'Agosto',
    9: 'Setembro',
    10: 'Outubro',
    11: 'Novembro',
    12: 'Dezembro',
  };

  String? ufSelecionada;
  int? mesSelecionado;

  @override
  void initState() {
    super.initState();
    ufSelecionada = widget.filtroAtual.uf;
    mesSelecionado = widget.filtroAtual.mes;
  }

  void _resetar() {
    setState(() {
      ufSelecionada = null;
      mesSelecionado = null;
    });
    Navigator.of(context).pop(const FiltroEvento());
  }

  void _aplicar() {
    Navigator.of(context).pop(
      FiltroEvento(uf: ufSelecionada, mes: mesSelecionado),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filtros', style: theme.textTheme.titleLarge),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: ufSelecionada,
            decoration: const InputDecoration(labelText: 'Estado'),
            items: ufs
                .map((uf) => DropdownMenuItem(value: uf, child: Text(uf)))
                .toList(),
            onChanged: (value) => setState(() => ufSelecionada = value),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            value: mesSelecionado,
            decoration: const InputDecoration(labelText: 'Mês'),
            items: meses.entries
                .map(
                  (entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => mesSelecionado = value),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetar,
                  child: const Text('RESETAR'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryCTA,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _aplicar,
                      child: const Text('APLICAR FILTROS'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
