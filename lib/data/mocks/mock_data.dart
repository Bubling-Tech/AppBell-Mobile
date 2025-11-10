import '../../domain/models/event.dart';
import '../../domain/models/feed_post.dart';
import '../../domain/models/ranking_entry.dart';
import '../../domain/models/user_profile.dart';

class MockData {
  const MockData._();

  static final List<Event> featuredEvents = [
    const Event(
      id: 'event_1',
      title: 'Bloco Vumbora',
      place: 'Palco Barra',
      cityState: 'Salvador, Bahia - Brasil',
      dateShort: '05 DE FEV',
      dateLong: '05 de fevereiro de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?q=80&w=1200&auto=format&fit=crop',
      lat: -12.9777,
      lon: -38.5016,
      checkins: 120,
      publications: 45,
      stage: 'Palco Barra',
      description: 'O Bloco Vumbora é um dos maiores e mais animados blocos de rua.',
    ),
    const Event(
      id: 'event_2',
      title: 'Bloco do Camaleão',
      place: 'Marco Zero',
      cityState: 'Recife, Pernambuco - Brasil',
      dateShort: '12 DE FEV',
      dateLong: '12 de fevereiro de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1469461084727-4bfb496cf55a?q=80&w=1200&auto=format&fit=crop',
      lat: -8.0543,
      lon: -34.8813,
      checkins: 88,
      publications: 30,
      stage: 'Marco Zero',
      description: 'O Camaleão arrasta multidões com muito axé e energia contagiante.',
    ),
  ];

  static final List<Event> allEvents = [
    const Event(
      id: 'event_3',
      title: 'Bloco Vumbora',
      place: 'Palco Principal',
      cityState: 'Salvador, Bahia - Brasil',
      dateShort: '03 FEV 2025',
      dateLong: '03 de fevereiro de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1200&auto=format&fit=crop',
      lat: -12.9777,
      lon: -38.5016,
      checkins: 20,
      publications: 5,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_4',
      title: 'Bloco do Camaleão',
      place: 'Palco Principal',
      cityState: 'Recife, Pernambuco - Brasil',
      dateShort: '05 FEV 2025',
      dateLong: '05 de fevereiro de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=1200&auto=format&fit=crop',
      lat: -8.0543,
      lon: -34.8813,
      checkins: 23,
      publications: 6,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_5',
      title: 'Bloco dos Namorados',
      place: 'Palco Principal',
      cityState: 'João Pessoa, Paraíba - Brasil',
      dateShort: '12 MAR 2025',
      dateLong: '12 de março de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1506157786151-b8491531f063?q=80&w=1200&auto=format&fit=crop',
      lat: -7.1195,
      lon: -34.8450,
      checkins: 26,
      publications: 7,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_6',
      title: 'Bloco Alegria Geral',
      place: 'Palco Principal',
      cityState: 'Fortaleza, Ceará - Brasil',
      dateShort: '18 ABR 2025',
      dateLong: '18 de abril de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=1200&auto=format&fit=crop',
      lat: -3.7319,
      lon: -38.5267,
      checkins: 29,
      publications: 8,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_7',
      title: 'Bloco Axé Folia',
      place: 'Palco Principal',
      cityState: 'Maceió, Alagoas - Brasil',
      dateShort: '27 FEV 2025',
      dateLong: '27 de fevereiro de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1506157786151-b8491531f063?q=80&w=1200&auto=format&fit=crop',
      lat: -9.6498,
      lon: -35.7089,
      checkins: 32,
      publications: 9,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_8',
      title: 'Bloco Mar Azul',
      place: 'Palco Principal',
      cityState: 'João Pessoa, Paraíba - Brasil',
      dateShort: '10 MAR 2025',
      dateLong: '10 de março de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1200&auto=format&fit=crop',
      lat: -7.1195,
      lon: -34.8450,
      checkins: 35,
      publications: 10,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_9',
      title: 'Bloco Energia Solar',
      place: 'Palco Principal',
      cityState: 'Fortaleza, Ceará - Brasil',
      dateShort: '12 FEV 2025',
      dateLong: '12 de fevereiro de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=1200&auto=format&fit=crop',
      lat: -3.7319,
      lon: -38.5267,
      checkins: 38,
      publications: 11,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_10',
      title: 'Bloco Aleluia',
      place: 'Palco Principal',
      cityState: 'Salvador, Bahia - Brasil',
      dateShort: '18 ABR 2025',
      dateLong: '18 de abril de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1506157786151-b8491531f063?q=80&w=1200&auto=format&fit=crop',
      lat: -12.9777,
      lon: -38.5016,
      checkins: 41,
      publications: 12,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_11',
      title: 'Bloco Sombra Boa',
      place: 'Palco Principal',
      cityState: 'Maceió, Alagoas - Brasil',
      dateShort: '27 FEV 2025',
      dateLong: '27 de fevereiro de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1200&auto=format&fit=crop',
      lat: -9.6498,
      lon: -35.7089,
      checkins: 44,
      publications: 13,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_12',
      title: 'Bloco Luz do Sol',
      place: 'Palco Principal',
      cityState: 'Recife, Pernambuco - Brasil',
      dateShort: '05 FEV 2025',
      dateLong: '05 de fevereiro de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=1200&auto=format&fit=crop',
      lat: -8.0543,
      lon: -34.8813,
      checkins: 47,
      publications: 14,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_13',
      title: 'Bloco Girassol',
      place: 'Palco Principal',
      cityState: 'João Pessoa, Paraíba - Brasil',
      dateShort: '12 MAR 2025',
      dateLong: '12 de março de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1506157786151-b8491531f063?q=80&w=1200&auto=format&fit=crop',
      lat: -7.1195,
      lon: -34.8450,
      checkins: 50,
      publications: 15,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
    const Event(
      id: 'event_14',
      title: 'Bloco Alegria Geral',
      place: 'Palco Principal',
      cityState: 'Fortaleza, Ceará - Brasil',
      dateShort: '18 ABR 2025',
      dateLong: '18 de abril de 2025',
      imageUrl:
          'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1200&auto=format&fit=crop',
      lat: -3.7319,
      lon: -38.5267,
      checkins: 53,
      publications: 16,
      stage: 'Palco Principal',
      description:
          'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    ),
  ];

  static final List<FeedPost> feedPosts = List.generate(6, (index) {
    return FeedPost(
      id: 'post_$index',
      userName: 'Usuário ${index + 1}',
      eventName: 'Bloco da Alegria ${index + 1}',
      imageUrl:
          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=900&q=80',
      avatarUrl: 'https://i.pravatar.cc/100?img=5',
    );
  });

  static final List<RankingEntry> ranking = [
    const RankingEntry(position: 1, name: 'Bruna Maria Souza', points: 10000, avatarUrl: 'https://i.pravatar.cc/200?img=47'),
    const RankingEntry(position: 2, name: 'João Silva', points: 9000, avatarUrl: 'https://i.pravatar.cc/200?img=12'),
    const RankingEntry(position: 3, name: 'Lucas Souza', points: 8000, avatarUrl: 'https://i.pravatar.cc/200?img=32'),
    const RankingEntry(position: 4, name: 'Bruna Maria Souza', points: 7000, avatarUrl: 'https://i.pravatar.cc/200?img=47'),
    const RankingEntry(position: 5, name: 'Aline Farias', points: 6500, avatarUrl: 'https://i.pravatar.cc/200?img=5'),
    const RankingEntry(position: 6, name: 'Hemily Barbosa', points: 5200, avatarUrl: 'https://i.pravatar.cc/200?img=15'),
    const RankingEntry(position: 7, name: 'Cleber Pereira', points: 4800, avatarUrl: 'https://i.pravatar.cc/200?img=68'),
    const RankingEntry(position: 8, name: 'Marcos Paulo', points: 4200, avatarUrl: 'https://i.pravatar.cc/200?img=28'),
  ];

  static final UserProfile profile = UserProfile(
    name: 'Matheus Ferreira',
    bio: 'Advogado e produtor de conteúdo',
    cityState: 'Localização atual - Aracaju/SE',
    avatarUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=800&auto=format&fit=crop',
    bannerUrl:
        'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=1600&auto=format&fit=crop',
    spotifySong: '“Mares do Sul” - Djavan',
    stats: const UserStats(rankPosition: '#14', checkins: '20'),
    posts: [
      const UserPost(
        title: 'PreCaju 2024',
        city: 'Aracaju-SE',
        imageUrl:
            'https://images.unsplash.com/photo-1541470074078-4f9a1e3d4d3f?q=80&w=1200&auto=format&fit=crop',
      ),
      const UserPost(
        title: 'PreCaju 2025',
        city: 'Aracaju-SE',
        imageUrl:
            'https://images.unsplash.com/photo-1487180144351-b8472da7d491?q=80&w=1200&auto=format&fit=crop',
      ),
      const UserPost(
        title: 'PreCaju 2024',
        city: 'Aracaju-SE',
        imageUrl:
            'https://images.unsplash.com/photo-1541470074078-4f9a1e3d4d3f?q=80&w=1200&auto=format&fit=crop',
      ),
      const UserPost(
        title: 'PreCaju 2025',
        city: 'Aracaju-SE',
        imageUrl:
            'https://images.unsplash.com/photo-1487180144351-b8472da7d491?q=80&w=1200&auto=format&fit=crop',
      ),
    ],
  );
}
