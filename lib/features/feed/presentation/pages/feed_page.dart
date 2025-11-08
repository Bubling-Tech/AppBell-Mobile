import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
import 'package:to_com_bell_app/core/widgets/app_gradient_button.dart';
import 'package:to_com_bell_app/features/checkin/presentation/widgets/checkin_modal.dart';
import 'package:to_com_bell_app/features/feed/controllers/feed_controller.dart';
import 'package:to_com_bell_app/features/feed/widgets/app_shell.dart';
import 'package:to_com_bell_app/features/feed/widgets/story_header.dart';
import 'package:to_com_bell_app/routes/app_routes.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late final FeedController controller;

  @override
  void initState() {
    super.initState();
    controller = FeedController();
  }

  Future<void> _abrirCheckin() async {
    final result = await CheckinModal.show(context);
    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check-in concluído!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final destaque = controller.destaque;
    return AppShell(
      current: BottomNavItem.feed,
      onCameraPressed: _abrirCheckin,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        titleSpacing: 24,
        title: Row(
          children: [
            const Icon(Icons.music_note_rounded, size: 28),
            const SizedBox(width: 8),
            Text(
              'Tô com Bell!',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Semantics(
              label: 'Abrir check-in',
              button: true,
              child: GestureDetector(
                onTap: _abrirCheckin,
                child: Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.bolt_rounded, color: Colors.white, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Check-in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        children: [
          StoryHeader(stories: controller.stories),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.network(
                    destaque['imagem']!,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.05),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(destaque['avatar']!),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              destaque['nome']!,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              destaque['evento']!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 180,
                        child: AppGradientButton(
                          label: 'QUERO FAZER CHECK-IN',
                          onPressed: _abrirCheckin,
                          height: 48,
                          borderRadius: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Eventos para entrar no clima',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          AppGradientButton(
            label: 'Explorar eventos',
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.eventos),
            height: 52,
            borderRadius: 20,
            icon: const Icon(Icons.event_available_rounded, size: 20),
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}
