import 'package:flutter/material.dart';

import '../core/gradients.dart';
import '../core/palette.dart';
import '../core/typography.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.value,
    required this.labelTop,
    this.labelBottom = '',
  });

  final String value;
  final String labelTop;
  final String labelBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Palette.borderSoft),
        boxShadow: const [
          BoxShadow(color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labelTop,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                ),
                if (labelBottom.isNotEmpty)
                  Text(
                    labelBottom,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Palette.textSecondary, fontSize: 11),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
