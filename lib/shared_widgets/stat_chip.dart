import 'package:flutter/material.dart';

import '../core/gradients.dart';
import '../core/palette.dart';
import '../core/typography.dart';

class StatChip extends StatelessWidget {
  const StatChip({super.key, required this.badgeText, required this.title});

  final String badgeText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Palette.borderChip),
        boxShadow: const [
          BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Color(0x33FF135E), blurRadius: 10, offset: Offset(0, 4)),
              ],
            ),
            child: Center(
              child: Text(badgeText, style: AppTypography.statBadge),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.statTitle,
            ),
          ),
        ],
      ),
    );
  }
}
