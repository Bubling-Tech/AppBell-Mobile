import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
import 'package:to_com_bell_app/core/theme/app_gradients.dart';

class StoryHeader extends StatelessWidget {
  const StoryHeader({super.key, required this.stories});

  final List<Map<String, String>> stories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 116,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) {
          final story = stories[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Semantics(
                label: 'Story de ${story['nome']}',
                button: true,
                child: Container(
                  width: 78,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 3,
                        margin: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
                        decoration: BoxDecoration(
                          gradient: AppGradients.primaryCTA,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          gradient: AppGradients.primaryCTA,
                          borderRadius: BorderRadius.circular(36),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 66,
                            height: 66,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(33),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(33),
                              child: Image.network(
                                story['avatar']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                story['nome']!,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textMedium,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: stories.length,
      ),
    );
  }
}
