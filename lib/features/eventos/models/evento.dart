class Evento {
  final String id;
  final String nome;
  final String cidade;
  final String estado;
  final DateTime data;
  final String imagemCapaUrl;
  final int checkinsNoEvento;
  final int publicacoes;
  final String local;

  const Evento({
    required this.id,
    required this.nome,
    required this.cidade,
    required this.estado,
    required this.data,
    required this.imagemCapaUrl,
    required this.checkinsNoEvento,
    required this.publicacoes,
    required this.local,
  });

  String get cidadeEstado => '$cidade - $estado';
}
