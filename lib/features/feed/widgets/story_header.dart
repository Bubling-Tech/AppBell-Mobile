import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_gradients.dart';

class StoryHeader extends StatelessWidget {
  const StoryHeader({super.key, required this.stories});

  final List<Map<String, String>> stories;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Column(
            children: [
              Semantics(
                label: 'Story de ' + story['nome']!,
                button: true,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        gradient: AppGradients.primaryCTA,
                        borderRadius: BorderRadius.circular(36),
                      ),
                    ),
                    Container(
                      width: 66,
                      height: 66,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(33),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(story['avatar']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                story['nome']!,
                style: Theme.of(context).textTheme.labelMedium,
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
