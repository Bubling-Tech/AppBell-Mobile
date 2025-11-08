import 'package:flutter/material.dart';

import '../core/palette.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({
    super.key,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final String hint;
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Palette.backgroundSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Palette.borderLighter),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                hint: Text(hint, style: const TextStyle(color: Color(0xFF9AA3B2))),
                items: items,
                onChanged: onChanged,
                icon: const SizedBox.shrink(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF3F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.expand_more, color: Color(0xFF7A8190)),
          ),
        ],
      ),
    );
  }
}
