import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
    return AppShell(
      current: BottomNavItem.feed,
      onCameraPressed: _abrirCheckin,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Icon(Icons.music_note_rounded),
            const SizedBox(width: 8),
            Text(
              'Tô com Bell!',
              style: theme.textTheme.titleMedium,
            ),
            const Spacer(),
            Semantics(
              label: 'Botão de check-in',
              button: true,
              child: ElevatedButton.icon(
                onPressed: _abrirCheckin,
                icon: const Icon(Icons.bolt_rounded),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                label: const Text('Check-in'),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          StoryHeader(stories: controller.stories),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1521337580396-0259d3921e89?auto=format&fit=crop&w=1200&q=80',
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bruna Maria Souza',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Aracaju - Pré-Caju',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.eventos),
                        child: const Text('Ver eventos'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
