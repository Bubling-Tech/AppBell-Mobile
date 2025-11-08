import 'package:flutter/material.dart';

import 'palette.dart';
import 'typography.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData build() {
    final base = ThemeData.light(useMaterial3: false);
    return base.copyWith(
      primaryColor: Palette.primaryPink,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: base.colorScheme.copyWith(
        primary: Palette.primaryPink,
        secondary: Palette.primaryOrange,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: AppTypography.sectionTitle,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Palette.textPrimary,
        displayColor: Palette.textPrimary,
      ),
      bottomAppBarTheme: base.bottomAppBarTheme.copyWith(color: Colors.white),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }
}
