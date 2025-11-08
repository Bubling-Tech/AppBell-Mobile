import 'package:flutter/material.dart';

import '../core/gradients.dart';
import '../core/palette.dart';
import '../core/typography.dart';

class InfoChip extends StatelessWidget {
  const InfoChip({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: Palette.backgroundSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Palette.borderSoft),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2B2F3A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
