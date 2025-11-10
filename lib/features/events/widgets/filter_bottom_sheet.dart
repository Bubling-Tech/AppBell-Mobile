import 'package:flutter/material.dart';

import '../../../shared_widgets/dropdown_field.dart';
import '../../../shared_widgets/gradient_button.dart';

class FilterResult {
  const FilterResult({this.state, this.month});

  final String? state;
  final String? month;
}

Future<FilterResult?> showFilterBottomSheet({
  required BuildContext context,
  required List<String> states,
  required List<String> months,
  String? selectedState,
  String? selectedMonth,
}) {
  return showModalBottomSheet<FilterResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.35),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      String? selEstado = selectedState;
      String? selMes = selectedMonth;
      final bottom = MediaQuery.of(ctx).viewInsets.bottom;

      return SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 16 + bottom),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 56,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7E9EE),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _FieldLabel('Estado:'),
                  DropdownField(
                    hint: 'Selecione um estado',
                    items: states
                        .map(
                          (uf) => DropdownMenuItem(
                            value: uf,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Color(0xFF0ACF83),
                                ),
                                const SizedBox(width: 8),
                                Text(uf),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    value: selEstado,
                    onChanged: (value) => setState(() => selEstado = value),
                  ),
                  const SizedBox(height: 18),
                  const _FieldLabel('Mês:'),
                  DropdownField(
                    hint: 'Selecione o mês',
                    items: months
                        .map(
                          (m) => DropdownMenuItem(
                            value: m,
                            child: Text(m),
                          ),
                        )
                        .toList(),
                    value: selMes,
                    onChanged: (value) => setState(() => selMes = value),
                  ),
                  const SizedBox(height: 18),
                  const Divider(height: 1, color: Color(0xFFE7EBF3)),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(ctx, const FilterResult(state: null, month: null));
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            side: const BorderSide(color: Color(0xFFE0E5EC), width: 1.2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            foregroundColor: const Color(0xFF2D3340),
                            textStyle: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          child: const Text('RESETAR'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GradientButton(
                          text: 'APLICAR FILTROS',
                          onPressed: () {
                            Navigator.pop(ctx, FilterResult(state: selEstado, month: selMes));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1D2630),
        ),
      ),
    );
  }
}
