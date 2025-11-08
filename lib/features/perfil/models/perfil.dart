class AlbumEvento {
  final String titulo;
  final String local;
  final String imagemUrl;

  const AlbumEvento({
    required this.titulo,
    required this.local,
    required this.imagemUrl,
  });
}

class Perfil {
  final String id;
  final String nome;
  final String bio;
  final String avatarUrl;
  final String localizacaoAtual;
  final int rankingAtual;
  final int checkinsRealizados;
  final List<AlbumEvento> albuns;

  const Perfil({
    required this.id,
    required this.nome,
    required this.bio,
    required this.avatarUrl,
    required this.localizacaoAtual,
    required this.rankingAtual,
    required this.checkinsRealizados,
    required this.albuns,
  });
}
