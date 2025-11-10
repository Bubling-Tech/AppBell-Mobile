import 'package:flutter/material.dart';

import '../core/gradients.dart';
import '../core/typography.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.height = 52,
    this.borderRadius = const BorderRadius.all(Radius.circular(14)),
    this.textStyle,
    this.boxShadow,
  });

  final String text;
  final VoidCallback? onPressed;
  final double height;
  final BorderRadius borderRadius;
  final TextStyle? textStyle;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GestureDetector(
        onTap: onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: borderRadius,
            boxShadow: boxShadow ??
                const [
                  BoxShadow(color: Color(0x26000000), blurRadius: 10, offset: Offset(0, 4)),
                ],
          ),
          child: Center(
            child: Text(
              text,
              style: textStyle ?? AppTypography.buttonText,
            ),
          ),
        ),
      ),
    );
  }
}
