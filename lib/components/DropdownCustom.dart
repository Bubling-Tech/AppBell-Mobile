import 'package:flutter/material.dart';


class DropdownCustom extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final String? labelText;
  final ValueChanged<String?> onChanged;

  const DropdownCustom({
    super.key,
    required this.items,
    required this.onChanged,
    this.initialValue,
    this.labelText,
  });

  @override
  _DropdownCustomState createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue ?? (widget.items.isNotEmpty ? widget.items[0] : null);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 2, left: 8),
              child: Text(
                widget.labelText!,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xFF50555C)),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFC5C5C5)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedValue,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                items: widget.items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                  widget.onChanged(newValue);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}