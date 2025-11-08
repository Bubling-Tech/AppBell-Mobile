class RankingEntry {
  final String nome;
  final String avatarUrl;
  final int pontos;
  final int? posicao;

  const RankingEntry({
    required this.nome,
    required this.avatarUrl,
    required this.pontos,
    this.posicao,
  });

  RankingEntry copyWith({int? posicao}) => RankingEntry(
        nome: nome,
        avatarUrl: avatarUrl,
        pontos: pontos,
        posicao: posicao ?? this.posicao,
      );
}
