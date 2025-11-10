class RankingEntry {
  const RankingEntry({
    required this.position,
    required this.name,
    required this.points,
    required this.avatarUrl,
  });

  final int position;
  final String name;
  final int points;
  final String avatarUrl;
}
