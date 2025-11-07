import 'package:to_com_bell_app/features/eventos/models/evento.dart';
import 'package:to_com_bell_app/features/perfil/models/perfil.dart';
import 'package:to_com_bell_app/features/ranking/models/ranking_entry.dart';

final List<Evento> mockEventos = [
  Evento(
    id: '1',
    nome: 'Bloco Vumbora',
    cidade: 'Salvador',
    estado: 'BA',
    data: DateTime(DateTime.now().year, 2, 17, 18),
    imagemCapaUrl:
        'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=1200&q=80',
    checkinsNoEvento: 50,
    publicacoes: 20,
    local: 'Circuito Dodô',
  ),
  Evento(
    id: '2',
    nome: 'Bloco do Camaleão',
    cidade: 'Salvador',
    estado: 'BA',
    data: DateTime(DateTime.now().year, 2, 16, 17),
    imagemCapaUrl:
        'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1200&q=80',
    checkinsNoEvento: 65,
    publicacoes: 32,
    local: 'Circuito Barra-Ondina',
  ),
  Evento(
    id: '3',
    nome: 'CarnaRecife',
    cidade: 'Recife',
    estado: 'PE',
    data: DateTime(DateTime.now().year, 2, 10, 19),
    imagemCapaUrl:
        'https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?auto=format&fit=crop&w=1200&q=80',
    checkinsNoEvento: 48,
    publicacoes: 18,
    local: 'Marco Zero',
  ),
  Evento(
    id: '4',
    nome: 'Frevo na Rua',
    cidade: 'Recife',
    estado: 'PE',
    data: DateTime(DateTime.now().year, 2, 12, 20),
    imagemCapaUrl:
        'https://images.unsplash.com/photo-1501621965065-c6e1cf6b53e2?auto=format&fit=crop&w=1200&q=80',
    checkinsNoEvento: 30,
    publicacoes: 12,
    local: 'Boa Vista',
  ),
  Evento(
    id: '5',
    nome: 'Micareta de Feira',
    cidade: 'Feira de Santana',
    estado: 'BA',
    data: DateTime(DateTime.now().year, 2, 20, 22),
    imagemCapaUrl:
        'https://images.unsplash.com/photo-1475724017904-b712052c192a?auto=format&fit=crop&w=1200&q=80',
    checkinsNoEvento: 22,
    publicacoes: 8,
    local: 'Avenida Presidente Dutra',
  ),
  Evento(
    id: '6',
    nome: 'Pré-Caju',
    cidade: 'Aracaju',
    estado: 'SE',
    data: DateTime(DateTime.now().year, 2, 2, 21),
    imagemCapaUrl:
        'https://images.unsplash.com/photo-1464375117522-1311d6a5b81f?auto=format&fit=crop&w=1200&q=80',
    checkinsNoEvento: 44,
    publicacoes: 16,
    local: 'Orla de Atalaia',
  ),
];

final List<RankingEntry> mockRanking = [
  RankingEntry(
    nome: 'Matheus Ferreira',
    avatarUrl:
        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
    pontos: 10000,
  ),
  RankingEntry(
    nome: 'Bruna Maria',
    avatarUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80',
    pontos: 9000,
  ),
  RankingEntry(
    nome: 'Carlos Eduardo',
    avatarUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
    pontos: 8000,
  ),
  RankingEntry(
    nome: 'Juliana Silva',
    avatarUrl:
        'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=80',
    pontos: 7000,
  ),
  RankingEntry(
    nome: 'Paulo Henrique',
    avatarUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=200&q=80',
    pontos: 6500,
  ),
  RankingEntry(
    nome: 'Fernanda Oliveira',
    avatarUrl:
        'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=80',
    pontos: 5500,
  ),
  RankingEntry(
    nome: 'João Lucas',
    avatarUrl:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=200&q=80',
    pontos: 4800,
  ),
  RankingEntry(
    nome: 'Ana Paula',
    avatarUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
    pontos: 4200,
  ),
  RankingEntry(
    nome: 'Lucas Martins',
    avatarUrl:
        'https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?auto=format&fit=crop&w=200&q=80',
    pontos: 3800,
  ),
  RankingEntry(
    nome: 'Maria Clara',
    avatarUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80',
    pontos: 3400,
  ),
];

const Perfil mockPerfil = Perfil(
  id: 'perfil-1',
  nome: 'Matheus Ferreira',
  bio: 'Carnavalesco apaixonado por música e experiências ao vivo.',
  avatarUrl:
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
  localizacaoAtual: 'Aracaju/SE',
  rankingAtual: 14,
  checkinsRealizados: 20,
  albuns: [
    'Pré-Caju 2024',
    'Pré-Caju 2025',
    'Folia Salvador',
    'Carna Recife',
  ],
);

final List<Map<String, String>> mockStories = [
  {
    'nome': 'Bruna',
    'avatar':
        'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=80'
  },
  {
    'nome': 'Matheus',
    'avatar':
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=200&q=80'
  },
  {
    'nome': 'Paulo',
    'avatar':
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80'
  },
  {
    'nome': 'Ana',
    'avatar':
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=200&q=80'
  },
  {
    'nome': 'João',
    'avatar':
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80'
  },
  {
    'nome': 'Clara',
    'avatar':
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80'
  },
];
