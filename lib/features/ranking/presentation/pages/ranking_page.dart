import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
import 'package:to_com_bell_app/core/utils/result.dart';
import 'package:to_com_bell_app/features/checkin/presentation/widgets/checkin_modal.dart';
import 'package:to_com_bell_app/features/feed/widgets/app_shell.dart';
import 'package:to_com_bell_app/features/ranking/controllers/ranking_controller.dart';
import 'package:to_com_bell_app/features/ranking/models/ranking_entry.dart';
import 'package:to_com_bell_app/features/ranking/widgets/ranking_podium.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  late final RankingController controller;

  @override
  void initState() {
    super.initState();
    controller = RankingController()..carregarRanking();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final estado = controller.ranking;
        Widget body;
        if (estado.status == ResultStatus.loading) {
          body = const Center(child: CircularProgressIndicator());
        } else if (estado.status == ResultStatus.error) {
          body = Center(child: Text(estado.message ?? 'Erro ao carregar ranking'));
        } else if (estado.status == ResultStatus.empty) {
          body = const Center(child: Text('Ranking vazio.'));
        } else {
          body = _RankingConteudo(entries: estado.data ?? const []);
        }
        return AppShell(
          current: BottomNavItem.ranking,
          onCameraPressed: () => CheckinModal.show(context),
          appBar: AppBar(
            titleSpacing: 24,
            title: const Text('Ranking geral'),
          ),
          body: body,
        );
      },
    );
  }
}

class _RankingConteudo extends StatelessWidget {
  const _RankingConteudo({required this.entries});

  final List<RankingEntry> entries;

  @override
  Widget build(BuildContext context) {
    final top3 = entries.take(3).toList();
    final demais = entries.skip(3).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      children: [
        if (top3.length == 3) RankingPodium(entries: top3),
        const SizedBox(height: 24),
        ...demais.map(
          (entry) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(entry.avatarUrl),
              ),
              title: Text(
                entry.nome,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              subtitle: Text(
                '${entry.pontos} pontos',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textMedium,
                    ),
              ),
              trailing: Text(
                '#${entry.posicao}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
