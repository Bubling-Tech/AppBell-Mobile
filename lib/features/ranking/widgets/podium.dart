import 'package:flutter/material.dart';

import '../../../domain/models/ranking_entry.dart';

class Podium extends StatelessWidget {
  const Podium({super.key, required this.top3});

  final List<RankingEntry> top3;

  static const _pink = Color(0xFFFF135E);
  static const _gold = Color(0xFFFFB703);
  static const _silver = Color(0xFFC0C7D1);
  static const _bronze = Color(0xFFCD7F32);

  @override
  Widget build(BuildContext context) {
    final data = [
      if (top3.length > 1) top3[1] else const RankingEntry(position: 2, name: '—', points: 0, avatarUrl: ''),
      if (top3.isNotEmpty) top3[0] else const RankingEntry(position: 1, name: '—', points: 0, avatarUrl: ''),
      if (top3.length > 2) top3[2] else const RankingEntry(position: 3, name: '—', points: 0, avatarUrl: ''),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: SizedBox(
        height: 290,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _PodiumColumn(
                place: 2,
                entry: data[0],
                pedestalColor: _silver,
                pedestalHeight: 90,
                badgeColor: _silver,
              ),
            ),
            Expanded(
              child: _PodiumColumn(
                place: 1,
                entry: data[1],
                pedestalColor: _pink,
                pedestalHeight: 120,
                badgeColor: _gold,
                isFirst: true,
              ),
            ),
            Expanded(
              child: _PodiumColumn(
                place: 3,
                entry: data[2],
                pedestalColor: _bronze,
                pedestalHeight: 90,
                badgeColor: _bronze,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PodiumColumn extends StatelessWidget {
  const _PodiumColumn({
    required this.place,
    required this.entry,
    required this.pedestalColor,
    required this.pedestalHeight,
    required this.badgeColor,
    this.isFirst = false,
  });

  final int place;
  final RankingEntry entry;
  final Color pedestalColor;
  final double pedestalHeight;
  final Color badgeColor;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final avatarSize = isFirst ? 84.0 : 72.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: avatarSize / 2 + 4,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: avatarSize / 2,
                backgroundImage: entry.avatarUrl.isEmpty ? null : NetworkImage(entry.avatarUrl),
                backgroundColor: const Color(0xFFECEFF4),
              ),
            ),
            Positioned(
              right: -4,
              top: -4,
              child: _MedalDot(color: badgeColor),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 120,
          child: Text(
            entry.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 6),
        _PointsPill(points: entry.points),
        const SizedBox(height: 12),
        Container(
          width: 110,
          height: pedestalHeight,
          decoration: BoxDecoration(
            color: pedestalColor.withOpacity(isFirst ? 1 : 0.9),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: Radius.circular(isFirst ? 0 : 8),
              bottomRight: Radius.circular(isFirst ? 0 : 8),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '$place',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _MedalDot extends StatelessWidget {
  const _MedalDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(color: Color(0x33000000), blurRadius: 6),
        ],
      ),
      child: const Icon(Icons.emoji_events_rounded, size: 14, color: Colors.white),
    );
  }
}

class _PointsPill extends StatelessWidget {
  const _PointsPill({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFF135E),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '${points.toString()} pontos',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}
