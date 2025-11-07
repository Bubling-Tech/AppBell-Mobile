import 'package:flutter/material.dart';
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
    controller = RankingController();
    controller.carregarRanking();
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
          appBar: AppBar(title: const Text('Ranking geral')),
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
    final demais = entries
        .where((entry) => entry.posicao == null || entry.posicao! > 3)
        .toList();
    return ListView(
      children: [
        RankingPodium(entries: entries),
        ...demais.map(
          (entry) => ListTile(
            leading:
                CircleAvatar(backgroundImage: NetworkImage(entry.avatarUrl)),
            title: Text(entry.nome),
            subtitle: Text('${entry.pontos} pontos'),
            trailing: Text('#${entry.posicao}'),
          ),
        ),
      ],
    );
  }
}
