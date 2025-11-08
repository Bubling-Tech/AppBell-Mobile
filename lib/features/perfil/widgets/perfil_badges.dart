import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';

class PerfilBadges extends StatelessWidget {
  const PerfilBadges({super.key, required this.ranking, required this.checkins});

  final int ranking;
  final int checkins;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Badge(
            title: '#$ranking',
            subtitle: 'Ranking atual',
            background: AppColors.surface,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _Badge(
            title: '$checkins',
            subtitle: 'Check-ins realizados',
            background: AppColors.surface,
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.title,
    required this.subtitle,
    required this.background,
  });

  final String title;
  final String subtitle;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textMedium,
                ),
          ),
        ],
      ),
    );
  }
}
