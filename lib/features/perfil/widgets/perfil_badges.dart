import 'package:flutter/material.dart';

class PerfilBadges extends StatelessWidget {
  const PerfilBadges({super.key, required this.ranking, required this.checkins});

  final int ranking;
  final int checkins;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('#$ranking', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('Ranking atual', style: theme.textTheme.labelMedium),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$checkins', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('Check-ins', style: theme.textTheme.labelMedium),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
