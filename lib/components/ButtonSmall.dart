import 'package:flutter/material.dart';

class ButtonSmall extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final List<Color> gradientColors;
  final int? borderColor;
  final int? textColor;

  const ButtonSmall({
    super.key,
    required this.onPressed,
    required this.text,
    required this.gradientColors,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            border: borderColor != null
                ? Border.all(color: Color(borderColor!), width: 1)
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Color(textColor ?? 0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
