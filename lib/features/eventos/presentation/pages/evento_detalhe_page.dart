import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
import 'package:to_com_bell_app/core/theme/app_gradients.dart';
import 'package:to_com_bell_app/core/utils/result.dart';
import 'package:to_com_bell_app/core/widgets/app_gradient_button.dart';
import 'package:to_com_bell_app/features/checkin/presentation/widgets/checkin_modal.dart';
import 'package:to_com_bell_app/features/checkin/controllers/checkin_controller.dart';
import 'package:to_com_bell_app/features/eventos/controllers/evento_detalhe_controller.dart';
import 'package:to_com_bell_app/features/eventos/models/evento.dart';
import 'package:to_com_bell_app/features/eventos/services/eventos_service.dart';

class EventoDetalhePage extends StatefulWidget {
  const EventoDetalhePage({super.key, required this.id});

  final String id;

  @override
  State<EventoDetalhePage> createState() => _EventoDetalhePageState();
}

class _EventoDetalhePageState extends State<EventoDetalhePage> {
  late final EventoDetalheController controller;
  late final CheckinController checkinController;

  @override
  void initState() {
    super.initState();
    controller = EventoDetalheController(EventosService());
    checkinController = CheckinController();
    controller.carregar(widget.id);
  }

  @override
  void dispose() {
    checkinController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> _fazerCheckin() async {
    final resultado = await CheckinModal.show(context);
    if (resultado == true) {
      await checkinController.realizarCheckin();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Check-in realizado com sucesso!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final estado = controller.evento;
        Widget body;
        if (estado.status == ResultStatus.loading) {
          body = const Center(child: CircularProgressIndicator());
        } else if (estado.status == ResultStatus.error) {
          body = Center(
            child: Text(estado.message ?? 'Erro ao carregar evento'),
          );
        } else if (estado.data != null) {
          body = _DetalheConteudo(
            evento: estado.data!,
            onCheckin: _fazerCheckin,
          );
        } else {
          body = const SizedBox.shrink();
        }
        return Scaffold(
          appBar: AppBar(),
          body: body,
        );
      },
    );
  }
}

class _DetalheConteudo extends StatelessWidget {
  const _DetalheConteudo({required this.evento, required this.onCheckin});

  final Evento evento;
  final VoidCallback onCheckin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dataFormatada = _formatarData(evento.data);
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [
            _HeaderImagem(url: evento.imagemCapaUrl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento.nome,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${evento.cidade}, ${evento.estado} – Brasil',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    shrinkWrap: true,
                    childAspectRatio: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _BadgeMetric(
                        value: '${evento.checkinsNoEvento}',
                        label: 'Check-ins nesse evento',
                        color: AppColors.badgeStrong,
                        background: AppColors.badgeHighlight,
                      ),
                      _BadgeMetric(
                        value: '${evento.publicacoes}',
                        label: 'Publicações',
                        color: AppColors.badgeStrong,
                        background: AppColors.badgeHighlight,
                      ),
                      _BadgeInfo(
                        icon: Icons.calendar_month_rounded,
                        label: dataFormatada,
                      ),
                      _BadgeInfo(
                        icon: Icons.location_on_rounded,
                        label: evento.local,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'A emoção toma conta das ruas com o ${evento.nome}. Venha curtir cada segundo dessa experiência inesquecível e compartilhar sua energia com a galera!',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textMedium,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: 24,
          right: 24,
          bottom: 24,
          child: SafeArea(
            child: AppGradientButton(
              label: 'QUERO FAZER CHECK-IN',
              onPressed: onCheckin,
            ),
          ),
        ),
      ],
    );
  }

  String _formatarData(DateTime data) {
    const meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro'
    ];
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');
    return '${data.day} ${meses[data.month - 1]} às $hora:${minuto}h';
  }
}

class _HeaderImagem extends StatelessWidget {
  const _HeaderImagem({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(url, fit: BoxFit.cover),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.primaryCTA,
              ),
              child: const Icon(Icons.favorite_border_rounded,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeMetric extends StatelessWidget {
  const _BadgeMetric({
    required this.value,
    required this.label,
    required this.color,
    required this.background,
  });

  final String value;
  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textMedium,
                ),
          ),
        ],
      ),
    );
  }
}

class _BadgeInfo extends StatelessWidget {
  const _BadgeInfo({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
