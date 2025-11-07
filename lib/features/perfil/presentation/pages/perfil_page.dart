import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
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
          appBar: AppBar(
            titleSpacing: 24,
            title: const Text('Meu perfil'),
          ),
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
      padding: EdgeInsets.zero,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                'https://images.unsplash.com/photo-1517630800677-932d836ab680?auto=format&fit=crop&w=1400&q=80',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -54,
              child: CircleAvatar(
                radius: 54,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(perfil.avatarUrl),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 72),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                perfil.nome,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                perfil.bio,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMedium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              PerfilBadges(
                ranking: perfil.rankingAtual,
                checkins: perfil.checkinsRealizados,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_rounded,
                        color: AppColors.secondary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        perfil.localizacaoAtual,
                        style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceMuted,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.music_note_rounded,
                              size: 16, color: AppColors.secondary),
                          SizedBox(width: 6),
                          Text('Spotify'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Meus eventos',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: perfil.albuns.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final album = perfil.albuns[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              album.imagemUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  album.titulo,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  album.local,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: AppColors.textMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
