import 'package:flutter/material.dart';
import 'palette.dart';

class AppGradients {
  const AppGradients._();

  static const LinearGradient primary = LinearGradient(
    colors: [Palette.primaryOrange, Palette.primaryPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient primaryDiagonal = LinearGradient(
    colors: [Palette.primaryOrange, Palette.primaryPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient overlay({double startOpacity = 0.05, double endOpacity = 0.4}) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(startOpacity),
        Colors.black.withOpacity(endOpacity),
      ],
    );
  }
}
