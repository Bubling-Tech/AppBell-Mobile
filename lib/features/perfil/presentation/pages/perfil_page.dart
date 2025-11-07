import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/utils/result.dart';
import 'package:to_com_bell_app/features/checkin/presentation/widgets/checkin_modal.dart';
import 'package:to_com_bell_app/features/feed/widgets/app_shell.dart';
import 'package:to_com_bell_app/features/perfil/controllers/perfil_controller.dart';
import 'package:to_com_bell_app/features/perfil/models/perfil.dart';
import 'package:to_com_bell_app/features/perfil/services/perfil_service.dart';
import 'package:to_com_bell_app/features/perfil/widgets/perfil_badges.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late final PerfilController controller;

  @override
  void initState() {
    super.initState();
    controller = PerfilController(PerfilService())..carregarPerfil();
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
        final estado = controller.perfil;
        Widget body;
        if (estado.status == ResultStatus.loading) {
          body = const Center(child: CircularProgressIndicator());
        } else if (estado.status == ResultStatus.error) {
          body = Center(child: Text(estado.message ?? 'Erro ao carregar perfil'));
        } else if (estado.data != null) {
          body = _PerfilConteudo(perfil: estado.data!);
        } else {
          body = const SizedBox.shrink();
        }
        return AppShell(
          current: BottomNavItem.perfil,
          onCameraPressed: () => CheckinModal.show(context),
          appBar: AppBar(title: const Text('Perfil')),
          body: body,
        );
      },
    );
  }
}

class _PerfilConteudo extends StatelessWidget {
  const _PerfilConteudo({required this.perfil});

  final Perfil perfil;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 200,
              child: Image.network(
                'https://images.unsplash.com/photo-1517630800677-932d836ab680?auto=format&fit=crop&w=1200&q=80',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: -48,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 56,
                  backgroundImage: NetworkImage(perfil.avatarUrl),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 56),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(perfil.nome, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                perfil.bio,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              PerfilBadges(
                ranking: perfil.rankingAtual,
                checkins: perfil.checkinsRealizados,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Localização atual'),
                            const SizedBox(height: 8),
                            Text(perfil.localizacaoAtual,
                                style: theme.textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.music_note_rounded),
                            const SizedBox(width: 12),
                            Text('Spotify', style: theme.textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Meus eventos', style: theme.textTheme.titleMedium),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                itemCount: perfil.albuns.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final album = perfil.albuns[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=800&q=80',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(album, style: theme.textTheme.titleSmall),
                              const SizedBox(height: 4),
                              Text(
                                perfil.localizacaoAtual,
                                style: theme.textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}
