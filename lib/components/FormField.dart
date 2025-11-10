import 'package:flutter/material.dart';

class FormFieldCustom extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final String? labelText;
  final ValueChanged<String>? onChanged;

  const FormFieldCustom({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.labelText,
    this.onChanged,
  });

  @override
  _FormFieldCustomState createState() => _FormFieldCustomState();
}

class _FormFieldCustomState extends State<FormFieldCustom> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
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
          TextField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false,
            autocorrect: false,
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFC5C5C5), width: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFC5C5C5), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFC5C5C5), width: 1),
              ),
              filled: true,
              fillColor: const Color(0xFFEEEEEE),
              prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      iconSize: 18,
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}
