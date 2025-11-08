import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
import 'package:to_com_bell_app/features/ranking/models/ranking_entry.dart';

class RankingPodium extends StatelessWidget {
  const RankingPodium({super.key, required this.entries});

  final List<RankingEntry> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.length < 3) {
      return const SizedBox.shrink();
    }
    final podium = [entries[1], entries[0], entries[2]];
    final heights = [160.0, 200.0, 140.0];
    final medals = [Icons.emoji_events, Icons.emoji_events, Icons.emoji_events];
    final medalColors = [
      Colors.grey.shade300,
      const Color(0xFFFFC107),
      const Color(0xFFCD7F32),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          final entry = podium[index];
          return _PodiumItem(
            entry: entry,
            height: heights[index],
            medalColor: medalColors[index],
            medalIcon: medals[index],
          );
        }),
      ),
    );
  }
}

class _PodiumItem extends StatelessWidget {
  const _PodiumItem({
    required this.entry,
    required this.height,
    required this.medalColor,
    required this.medalIcon,
  });

  final RankingEntry entry;
  final double height;
  final Color medalColor;
  final IconData medalIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: entry.posicao == 1 ? 46 : 38,
          backgroundImage: NetworkImage(entry.avatarUrl),
        ),
        const SizedBox(height: 12),
        Text(
          entry.nome,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          '${entry.pontos} pts',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textMedium,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 88,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                medalColor.withOpacity(0.1),
                medalColor.withOpacity(0.6),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(medalIcon, color: medalColor, size: 24),
              const SizedBox(height: 8),
              Text(
                '#${entry.posicao}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textStrong,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
