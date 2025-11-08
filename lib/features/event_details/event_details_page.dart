import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/palette.dart';
import '../../data/mocks/service_locator.dart';
import '../../domain/models/event.dart';
import '../../shared_widgets/gradient_button.dart';
import '../../shared_widgets/info_chip.dart';
import '../../shared_widgets/metric_card.dart';
import 'widgets/checkin_dialog.dart';
import 'widgets/checkin_success_dialog.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key, required this.event});

  final Event event;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool _favorite = false;
  bool _checkinDialogOpen = false;

  double _chipWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return (w - 32 - 12) / 2;
  }

  @override
  Widget build(BuildContext context) {
    final chipW = _chipWidth(context);
    final event = widget.event;
    final tag = event.imageUrl;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                onPressed: () => setState(() => _favorite = !_favorite),
                icon: Icon(
                  _favorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: tag,
                    child: Image.network(event.imageUrl, fit: BoxFit.cover),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black38, Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111418),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              event.cityState,
                              style: const TextStyle(
                                color: Palette.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => _favorite = !_favorite),
                        icon: Icon(
                          _favorite ? Icons.favorite : Icons.favorite_border,
                          color: _favorite ? Palette.primaryPink : Palette.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: chipW,
                        child: MetricCard(
                          value: event.checkins.toString(),
                          labelTop: 'Check-ins',
                          labelBottom: 'nesse evento',
                        ),
                      ),
                      SizedBox(
                        width: chipW,
                        child: MetricCard(
                          value: event.publications.toString(),
                          labelTop: 'Publicações',
                        ),
                      ),
                      SizedBox(
                        width: chipW,
                        child: InfoChip(
                          icon: Icons.calendar_today_outlined,
                          text: event.dateLong,
                        ),
                      ),
                      SizedBox(
                        width: chipW,
                        child: InfoChip(
                          icon: Icons.storefront_outlined,
                          text: event.stage,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    event.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      color: Color(0xFF2B2F3A),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: GradientButton(
            text: 'QUERO FAZER CHECK-IN',
            height: 52,
            borderRadius: BorderRadius.circular(12),
            onPressed: _startCheckinFlow,
          ),
        ),
      ),
    );
  }

  Future<void> _startCheckinFlow() async {
    if (_checkinDialogOpen) return;
    _checkinDialogOpen = true;
    final controller = StreamController<CheckinState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CheckinDialog(
        states: controller.stream,
        onRetry: () {
          Navigator.pop(context);
          controller.close();
          _checkinDialogOpen = false;
          _startCheckinFlow();
        },
        onCancel: () {
          Navigator.pop(context);
          controller.close();
          _checkinDialogOpen = false;
        },
        onSuccess: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          controller.close();
          _checkinDialogOpen = false;
          _showSuccessDialog();
        },
      ),
    );

    await _handleCheckin(controller);
  }

  Future<void> _handleCheckin(StreamController<CheckinState> controller) async {
    try {
      controller.add(const CheckinState.loading('Solicitando permissão...'));
      final granted = await SL.location.ensurePermission();
      if (!granted) {
        controller.add(const CheckinState.error(
          'Permissão de localização negada.\nHabilite a permissão para continuar.',
        ));
        return;
      }

      controller.add(const CheckinState.loading('Obtendo sua localização...'));
      final current = await SL.location.getCurrent();

      controller.add(const CheckinState.loading('Validando distância...'));
      final distance = await SL.location.distanceBetween(
        current.lat,
        current.lon,
        widget.event.lat,
        widget.event.lon,
      );

      if (distance <= 150) {
        controller.add(const CheckinState.success('Localização confirmada.'));
      } else {
        controller.add(CheckinState.error(
          'Você está a ~${distance.toStringAsFixed(0)}m do ponto.\n'
          'É preciso estar dentro de 150m para fazer o check-in.',
        ));
      }
    } catch (e) {
      controller.add(CheckinState.error('Falha ao verificar localização.\n$e'));
    }
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return CheckinSuccessDialog(
          onPrimary: () async {
            Navigator.pop(ctx);
            await SL.camera.openCameraAndReturn(context);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Publicação criada no feed!')),
              );
            }
          },
        );
      },
    );
  }
}
