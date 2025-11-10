import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../core/gradients.dart';

class GradientFab extends StatelessWidget {
  const GradientFab({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      elevation: 1,
      fillColor: Colors.transparent,
      constraints: const BoxConstraints.tightFor(width: 64, height: 64),
      shape: const CircleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppGradients.primaryDiagonal,
        ),
        child: const Center(
          child: Icon(
            Symbols.photo_camera,
            color: Colors.white,
            size: 26,
            fill: 1,
            weight: 700,
          ),
        ),
      ),
    );
  }
}
