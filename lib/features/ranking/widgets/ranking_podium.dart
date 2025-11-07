import 'package:flutter/material.dart';
import 'package:to_com_bell_app/features/ranking/models/ranking_entry.dart';

class RankingPodium extends StatelessWidget {
  const RankingPodium({super.key, required this.entries});

  final List<RankingEntry> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.length < 3) {
      return const SizedBox.shrink();
    }
    final medalColors = [Colors.amber, Colors.grey.shade400, Colors.brown.shade400];
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _PodiumItem(entry: entries[1], color: medalColors[1], height: 140),
            _PodiumItem(entry: entries[0], color: medalColors[0], height: 180),
            _PodiumItem(entry: entries[2], color: medalColors[2], height: 120),
          ],
        ),
      ),
    );
  }
}

class _PodiumItem extends StatelessWidget {
  const _PodiumItem({
    required this.entry,
    required this.color,
    required this.height,
  });

  final RankingEntry entry;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(entry.avatarUrl),
        ),
        const SizedBox(height: 12),
        Text(entry.nome, style: Theme.of(context).textTheme.labelLarge),
        Text('${entry.pontos} pts',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 12),
        Semantics(
          label: 'Posição ${entry.posicao}',
          child: Container(
            width: 72,
            height: height,
            decoration: BoxDecoration(
              color: color.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '#${entry.posicao}',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
