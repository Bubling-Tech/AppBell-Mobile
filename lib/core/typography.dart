import 'package:flutter/material.dart';
import 'palette.dart';

class AppTypography {
  const AppTypography._();

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Palette.textPrimary,
  );

  static const TextStyle sectionAction = TextStyle(
    fontWeight: FontWeight.w600,
    color: Palette.primaryPink,
  );

  static const TextStyle chipLabel = TextStyle(
    fontSize: 12.5,
    color: Palette.textSoft,
  );

  static const TextStyle chipLabelStrong = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Palette.textPrimary,
  );

  static const TextStyle statTitle = TextStyle(
    fontSize: 13.5,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle statBadge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    color: Colors.white,
  );

  static const TextStyle buttonText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.3,
  );
}
