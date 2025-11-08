import 'package:flutter/material.dart';

import '../../core/palette.dart';
import '../../data/mocks/service_locator.dart';
import '../../domain/models/ranking_entry.dart';
import 'widgets/podium.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with AutomaticKeepAliveClientMixin<RankingPage> {
  late Future<List<RankingEntry>> _rankingFuture;

  @override
  void initState() {
    super.initState();
    _rankingFuture = SL.ranking.getRanking();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Palette.backgroundLight,
      body: SafeArea(
        child: FutureBuilder<List<RankingEntry>>(
          future: _rankingFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final ranking = [...snapshot.data!]
              ..sort((a, b) => a.position.compareTo(b.position));
            final top3 = ranking.take(3).toList();
            final rest = ranking.skip(3).toList();

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Center(
                      child: Text(
                        'Ranking geral',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Podium(top3: top3),
                ),
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
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: rest.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, index) {
                        final entry = rest[index];
                        return _RankCard(entry: entry);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RankCard extends StatelessWidget {
  const _RankCard({required this.entry});

  final RankingEntry entry;

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
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFE6E9F0),
            child: Text(
              '${entry.position}',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          title: Text(
            entry.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${entry.points} pontos',
            style: const TextStyle(color: Color(0xFF7A8190)),
          ),
          trailing: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(entry.avatarUrl),
          ),
        ),
      ),
    );
  }
}
