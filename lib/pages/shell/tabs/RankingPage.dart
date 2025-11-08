import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});
  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // MOCK: dados de exemplo (pode trocar por sua API)
  final List<_UserRank> _users = [
    _UserRank('Bruna Maria Souza', 10000, 'https://i.pravatar.cc/200?img=47'),
    _UserRank('João Silva', 9000, 'https://i.pravatar.cc/200?img=12'),
    _UserRank('Lucas Souza', 8000, 'https://i.pravatar.cc/200?img=32'),
    _UserRank('Bruna Maria Souza', 7000, 'https://i.pravatar.cc/200?img=47'),
    _UserRank('Aline Farias', 6500, 'https://i.pravatar.cc/200?img=5'),
    _UserRank('Hemily Barbosa', 5200, 'https://i.pravatar.cc/200?img=15'),
    _UserRank('Cleber Pereira', 4800, 'https://i.pravatar.cc/200?img=68'),
    _UserRank('Marcos Paulo', 4200, 'https://i.pravatar.cc/200?img=28'),
  ];

  // Cores base
  static const _pink = Color(0xFFFF135E);
  static const _gold = Color(0xFFFFB703);
  static const _silver = Color(0xFFC0C7D1);
  static const _bronze = Color(0xFFCD7F32);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Ordena por pontos (desc)
    final sorted = [..._users]..sort((a, b) => b.points.compareTo(a.points));
    final top3 = sorted.take(3).toList();
    final rest = sorted.skip(3).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Center(
                  child: Text(
                    'Ranking geral',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            // PÓDIO TOP 3
            SliverToBoxAdapter(
              child: _Podium(top3: top3),
            ),

            // Lista 4..N dentro de um container branco
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rest.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final user = rest[i];
                    final rank = i + 4; // começa no quarto
                    return _RankCard(
                      rank: rank,
                      name: user.name,
                      points: user.points,
                      avatarUrl: user.avatarUrl,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======= MODELOS =======
class _UserRank {
  final String name;
  final int points;
  final String avatarUrl;
  _UserRank(this.name, this.points, this.avatarUrl);
}

// ======= WIDGETS =======

class _Podium extends StatelessWidget {
  const _Podium({required this.top3});

  final List<_UserRank> top3;

  static const _pink = Color(0xFFFF135E);
  static const _gold = Color(0xFFFFB703);
  static const _silver = Color(0xFFC0C7D1);
  static const _bronze = Color(0xFFCD7F32);

  @override
  Widget build(BuildContext context) {
    // garante 3 itens (se vier menos)
    final data = [
      if (top3.length > 1) top3[1] else _UserRank('—', 0, ''),
      if (top3.isNotEmpty) top3[0] else _UserRank('—', 0, ''),
      if (top3.length > 2) top3[2] else _UserRank('—', 0, ''),
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
                user: data[0],
                pedestalColor: _silver,
                pedestalHeight: 90,
                badgeColor: _silver,
              ),
            ),
            Expanded(
              child: _PodiumColumn(
                place: 1,
                user: data[1],
                pedestalColor: _pink,
                pedestalHeight: 120,
                badgeColor: _gold,
                isFirst: true,
              ),
            ),
            Expanded(
              child: _PodiumColumn(
                place: 3,
                user: data[2],
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
    required this.user,
    required this.pedestalColor,
    required this.pedestalHeight,
    required this.badgeColor,
    this.isFirst = false,
  });

  final int place;
  final _UserRank user;
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
        // Avatar + medalha + nome + pontos
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Avatar com borda
            CircleAvatar(
              radius: avatarSize / 2 + 4,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: avatarSize / 2,
                backgroundImage:
                user.avatarUrl.isEmpty ? null : NetworkImage(user.avatarUrl),
                backgroundColor: const Color(0xFFECEFF4),
              ),
            ),

            // Badge (medalha)
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
            user.name,
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
        _PointsPill(points: user.points),
        const SizedBox(height: 12),

        // Pedestal com número do lugar
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
              )
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

class _RankCard extends StatelessWidget {
  const _RankCard({
    required this.rank,
    required this.name,
    required this.points,
    required this.avatarUrl,
  });

  final int rank;
  final String name;
  final int points;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFDFDFE),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 3)),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFE6E9F0),
                child: Text(
                  '$rank',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${points} pontos',
            style: const TextStyle(color: Color(0xFF7A8190)),
          ),
          trailing: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(avatarUrl),
          ),
        ),
      ),
    );
  }
}
