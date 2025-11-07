import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
import 'package:to_com_bell_app/features/eventos/models/evento.dart';

class EventListItem extends StatelessWidget {
  const EventListItem({super.key, required this.evento, this.onTap});

  final Evento evento;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dataLabel =
        '${evento.data.day.toString().padLeft(2, '0')}/${evento.data.month.toString().padLeft(2, '0')}';
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                evento.imagemCapaUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento.nome,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${evento.cidade}, ${evento.estado} – Brasil',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMedium,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Data: $dataLabel',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textWeak,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textWeak),
          ],
        ),
      ),
    );
  }
}
