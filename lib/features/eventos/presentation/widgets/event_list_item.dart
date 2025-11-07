import 'package:flutter/material.dart';
import 'package:to_com_bell_app/features/eventos/models/evento.dart';

class EventListItem extends StatelessWidget {
  const EventListItem({super.key, required this.evento, this.onTap});

  final Evento evento;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dataLabel =
        '${evento.data.day.toString().padLeft(2, '0')}/${evento.data.month.toString().padLeft(2, '0')}';
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          evento.imagemCapaUrl,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(evento.nome),
      subtitle: Text(evento.cidadeEstado + ' · ' + dataLabel),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}
