import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
import 'package:to_com_bell_app/core/widgets/app_gradient_button.dart';
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
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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

  void _aplicar() {
    Navigator.of(context).pop(
      FiltroEvento(uf: ufSelecionada, mes: mesSelecionado),
    );
  }

  void _resetar() {
    Navigator.of(context).pop(const FiltroEvento());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Container(
        height: size.height * 0.6,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.14),
              blurRadius: 24,
              offset: const Offset(0, -12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Text(
              'Filtros de eventos',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 24),
            _buildDropdownUf(context),
            const SizedBox(height: 16),
            const Divider(color: AppColors.border, thickness: 1),
            const SizedBox(height: 16),
            _buildDropdownMes(context),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetar,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('RESETAR'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppGradientButton(
                    label: 'APLICAR FILTROS',
                    onPressed: _aplicar,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownUf(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: ufSelecionada,
      borderRadius: BorderRadius.circular(16),
      decoration: InputDecoration(
        labelText: 'Estado',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 12),
          child: Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentGreen,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 40),
      ),
      items: ufs
          .map(
            (uf) => DropdownMenuItem(value: uf, child: Text(uf)),
          )
          .toList(),
      onChanged: (value) => setState(() => ufSelecionada = value),
    );
  }

  Widget _buildDropdownMes(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: mesSelecionado,
      borderRadius: BorderRadius.circular(16),
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
    );
  }
}
