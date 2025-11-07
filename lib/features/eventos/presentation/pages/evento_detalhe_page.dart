import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_gradients.dart';
import 'package:to_com_bell_app/core/utils/result.dart';
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
    final meses = [
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
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final estado = controller.evento;
        Widget body;
        if (estado.status == ResultStatus.loading) {
          body = const Center(child: CircularProgressIndicator());
        } else if (estado.status == ResultStatus.error) {
          body = Center(child: Text(estado.message ?? 'Erro ao carregar evento'));
        } else if (estado.data != null) {
          final data = estado.data!.data;
          final dataFormatada =
              '${data.day.toString().padLeft(2, '0')} ${meses[data.month - 1]} às ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}h';
          body = _DetalheConteudo(
            evento: estado.data!,
            dataFormatada: dataFormatada,
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
  const _DetalheConteudo({
    required this.evento,
    required this.dataFormatada,
    required this.onCheckin,
  });

  final Evento evento;
  final String dataFormatada;
  final VoidCallback onCheckin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderImagem(url: evento.imagemCapaUrl),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            evento.nome,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            evento.cidade + ', ' + evento.estado + ' - Brasil',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border_rounded),
                      tooltip: 'Favoritar',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _BadgeNumero(
                      label: 'Check-ins',
                      value: evento.checkinsNoEvento.toString(),
                    ),
                    _BadgeNumero(
                      label: 'Publicações',
                      value: evento.publicacoes.toString(),
                    ),
                    _BadgeIcone(
                      icon: Icons.calendar_month_rounded,
                      label: dataFormatada,
                    ),
                    _BadgeIcone(
                      icon: Icons.location_on_rounded,
                      label: evento.local,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'A emoção toma conta das ruas com o ${evento.nome}. Venha curtir cada segundo dessa experiência inesquecível e compartilhar sua energia com a galera!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryCTA,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: onCheckin,
                      child: const Text('QUERO FAZER CHECK-IN'),
                    ),
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

class _HeaderImagem extends StatelessWidget {
  const _HeaderImagem({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _HeaderClipper(),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 24)
      ..quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height - 24,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _BadgeNumero extends StatelessWidget {
  const _BadgeNumero({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade400.withOpacity(0.85),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeIcone extends StatelessWidget {
  const _BadgeIcone({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
