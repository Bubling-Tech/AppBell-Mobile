import 'package:flutter/material.dart';

import '../../../core/palette.dart';

class SpotifyChip extends StatelessWidget {
  const SpotifyChip({super.key, required this.song});

  final String song;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Palette.spotifyGreen.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Palette.spotifyGreen.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.music_note, color: Palette.spotifyGreen, size: 16),
          const SizedBox(width: 6),
          Text(
            song,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Palette.spotifyGreen,
            ),
          ),
        ],
      ),
    );
  }
}
