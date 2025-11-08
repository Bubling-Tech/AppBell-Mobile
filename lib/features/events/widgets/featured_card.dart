import 'package:flutter/material.dart';

import '../../../core/gradients.dart';
import '../../../domain/models/event.dart';
import '../../../shared_widgets/gradient_button.dart';

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key, required this.event, required this.heroTag, this.onTap});

  final Event event;
  final Object heroTag;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 290,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 6)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: Hero(
                  tag: heroTag,
                  child: Image.network(event.imageUrl, fit: BoxFit.cover),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: AppGradients.overlay(startOpacity: 0.05, endOpacity: 0.4),
                ),
              ),
              if (event.dateShort.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0ACF83),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      event.dateShort,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      event.cityState,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GradientButton(
                      text: 'SAIBA MAIS',
                      height: 36,
                      borderRadius: BorderRadius.circular(10),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
