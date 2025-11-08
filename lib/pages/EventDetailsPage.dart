import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({
    super.key,
    required this.titulo,
    required this.local,
    required this.dataHora,
    required this.imgUrl,
    required this.latitude,
    required this.longitude,
    this.heroTag,
    this.checkins = 0,
    this.publicacoes = 0,
    this.palco = 'Palco',
    this.descricao =
    'O Bloco do Vumbora é um dos maiores e mais animados blocos de rua de Salvador...',
    this.debugForceSuccess = true,      // simular sucesso de check-in
    this.goToHome,                       // callback para ir ao feed (Home)
  });

  final String titulo;
  final String local;
  final String dataHora;
  final String imgUrl;
  final double latitude;
  final double longitude;
  final String? heroTag;
  final int checkins;
  final int publicacoes;
  final String palco;
  final String descricao;

  final bool debugForceSuccess;

  /// Se fornecido, será chamado quando a câmera terminar (para trocar para a Home).
  final VoidCallback? goToHome;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool _favorito = false;

  // Paleta
  static const grad1 = Color(0xFFFF5125);
  static const grad2 = Color(0xFFFF135E);
  static const border = Color(0xFFE6E9F1);
  static const grayText = Color(0xFF7A8190);
  static const double _raioCheckinMetros = 150;

  double _chipWidth(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    return (w - 32 - 12) / 2; // 2 colunas
  }

  @override
  Widget build(BuildContext context) {
    final chipW = _chipWidth(context);
    final tag = widget.heroTag ?? widget.imgUrl;

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
                onPressed: () => setState(() => _favorito = !_favorito),
                icon: Icon(
                  _favorito ? Icons.favorite : Icons.favorite_border,
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
                    child: Image.network(widget.imgUrl, fit: BoxFit.cover),
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
                              widget.titulo,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111418),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.local,
                              style: const TextStyle(
                                color: grayText,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => _favorito = !_favorito),
                        icon: Icon(
                          _favorito ? Icons.favorite : Icons.favorite_border,
                          color: _favorito ? grad2 : grayText,
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
                        child: _MetricChip(
                          value: widget.checkins.toString(),
                          labelTop: 'Check-ins',
                          labelBottom: 'nesse evento',
                        ),
                      ),
                      SizedBox(
                        width: chipW,
                        child: _MetricChip(
                          value: widget.publicacoes.toString(),
                          labelTop: 'Publicações',
                          labelBottom: '',
                        ),
                      ),
                      SizedBox(
                        width: chipW,
                        child: _InfoChip(
                          icon: Icons.calendar_today_outlined,
                          text: widget.dataHora,
                        ),
                      ),
                      SizedBox(
                        width: chipW,
                        child: _InfoChip(
                          icon: Icons.storefront_outlined,
                          text: widget.palco,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    widget.descricao,
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
          child: SizedBox(
            height: 52,
            child: GestureDetector(
              onTap: _startCheckinFlow,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [grad1, grad2],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'QUERO FAZER CHECK-IN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================== Check-in ==================

  Future<void> _startCheckinFlow() async {
    final controller = StreamController<_CheckinState>();
    _showCheckinDialog(controller.stream, onClose: () => controller.close());

    try {
      controller.add(const _CheckinState.loading('Solicitando permissão...'));

      if (!await _ensureLocationPermission()) {
        controller.add(const _CheckinState.error(
          'Permissão de localização negada.\nHabilite a permissão para continuar.',
        ));
        return;
      }

      controller.add(const _CheckinState.loading('Obtendo sua localização...'));

      // simulação de sucesso
      if (widget.debugForceSuccess) {
        await Future.delayed(const Duration(milliseconds: 700));
        controller.add(const _CheckinState.ok('Localização confirmada.'));
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      controller.add(const _CheckinState.loading('Validando distância...'));

      final dist = Geolocator.distanceBetween(
        pos.latitude,
        pos.longitude,
        widget.latitude,
        widget.longitude,
      );

      if (dist <= _raioCheckinMetros) {
        controller.add(_CheckinState.ok(
          'Você está a ~${dist.toStringAsFixed(0)}m do ponto. Localização confirmada!',
        ));
      } else {
        controller.add(_CheckinState.error(
          'Você está a ~${dist.toStringAsFixed(0)}m do ponto.\n'
              'É preciso estar dentro de ${_raioCheckinMetros.round()}m para fazer o check-in.',
        ));
      }
    } catch (e) {
      controller.add(_CheckinState.error('Falha ao verificar localização.\n$e'));
    }
  }

  Future<bool> _ensureLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }
    if (permission == LocationPermission.deniedForever) return false;

    return true;
  }

  void _showCheckinDialog(Stream<_CheckinState> states, {VoidCallback? onClose}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: StreamBuilder<_CheckinState>(
            stream: states,
            initialData:
            const _CheckinState.loading('Verificando sua localização...'),
            builder: (context, snap) {
              final data = snap.data!;

              // Sucesso → popup do mock e depois câmera
              if (data.status == _CheckinStatus.ok) {
                return _SuccessDialog(
                  onPrimary: () async {
                    Navigator.pop(context); // fecha o dialog
                    await _openCameraThenHome(); // abre câmera e depois Home
                    onClose?.call();
                  },
                );
              }

              // Loading / Erro
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _DialogHeaderIcon(status: data.status),
                    const SizedBox(height: 12),
                    Text(
                      data.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, height: 1.35),
                    ),
                    const SizedBox(height: 16),
                    if (data.status == _CheckinStatus.loading)
                      const _LoadingBar(),
                    if (data.status == _CheckinStatus.error)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(48),
                                side: const BorderSide(color: Color(0xFFE0E5EC)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                onClose?.call();
                              },
                              child: const Text('Cancelar'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(48),
                                backgroundColor: _EventDetailsPageState.grad2,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                onClose?.call();
                                _startCheckinFlow();
                              },
                              child: const Text('Tentar novamente'),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ).then((_) => onClose?.call());
  }

  /// Abre a câmera e, ao concluir, volta para o feed (Home).
  Future<void> _openCameraThenHome() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CameraMockPage()),
    );

    // Se o AppShell passou um callback, usamos ele para trocar a tab para Home.
    widget.goToHome?.call();

    // Garante que voltamos para a pilha principal (se necessário).
    if (mounted) {
      // Se você quiser forçar voltar ao primeiro route:
      // Navigator.of(context).popUntil((r) => r.isFirst);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Publicação criada no feed!')),
      );
    }
  }
}

// =================== Suporte: estados e UI do diálogo ===================

enum _CheckinStatus { loading, ok, error }

class _CheckinState {
  final _CheckinStatus status;
  final String message;
  const _CheckinState._(this.status, this.message);
  const _CheckinState.loading(this.message) : status = _CheckinStatus.loading;
  const _CheckinState.ok(this.message) : status = _CheckinStatus.ok;
  const _CheckinState.error(this.message) : status = _CheckinStatus.error;
}

class _DialogHeaderIcon extends StatelessWidget {
  const _DialogHeaderIcon({required this.status});
  final _CheckinStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _CheckinStatus.loading:
        return Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_EventDetailsPageState.grad1, _EventDetailsPageState.grad2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        );
      case _CheckinStatus.ok:
        return const SizedBox.shrink();
      case _CheckinStatus.error:
        return Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFFDECEA),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF5C2C0)),
          ),
          child: const Icon(Icons.error_outline, color: Color(0xFFE74C3C), size: 34),
        );
    }
  }
}

class _LoadingBar extends StatelessWidget {
  const _LoadingBar();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2F6),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(999)),
            child: LinearProgressIndicator(
              minHeight: 6,
              backgroundColor: Colors.transparent,
              valueColor:
              AlwaysStoppedAnimation<Color>(_EventDetailsPageState.grad2),
            ),
          ),
        ),
      ],
    );
  }
}

/// Pop-up de sucesso conforme o mock (imagem de mapa + CTA)
class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({required this.onPrimary});
  final VoidCallback onPrimary;

  static const _illustrationUrl =
      'https://images.unsplash.com/photo-1528909514045-2fa4ac7a08ba?q=80&w=1200&auto=format&fit=crop&sat=-100';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 190,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  _illustrationUrl,
                  fit: BoxFit.cover,
                  color: Colors.white,
                  colorBlendMode: BlendMode.modulate,
                ),
                Container(color: Colors.white.withOpacity(0.6)),
                const Center(child: _PinPulse()),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sua energia chegou\njunto com você!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111418),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Veja sua localização no mapa e mostre pra galera que você está curtindo o evento de perto.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.35,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _EventDetailsPageState.grad2,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ).copyWith(
                      backgroundColor: WidgetStateProperty.all(Colors.transparent),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    onPressed: onPrimary,
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            _EventDetailsPageState.grad1,
                            _EventDetailsPageState.grad2
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'VAMOS LÁ, POSTE E CURTA!',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
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

/// Pin com pulso sutil
class _PinPulse extends StatefulWidget {
  const _PinPulse();

  @override
  State<_PinPulse> createState() => _PinPulseState();
}

class _PinPulseState extends State<_PinPulse> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ScaleTransition(
          scale: Tween(begin: 0.85, end: 1.05).animate(
            CurvedAnimation(parent: _c, curve: Curves.easeInOut),
          ),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEFEF),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF135E).withOpacity(0.25),
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_EventDetailsPageState.grad1, _EventDetailsPageState.grad2],
            ),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0x33FF135E),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.place, color: Colors.white, size: 20),
        ),
      ],
    );
  }
}

// ---------- Chips ----------
class _MetricChip extends StatelessWidget {
  const _MetricChip({
    required this.value,
    required this.labelTop,
    required this.labelBottom,
  });

  final String value;
  final String labelTop;
  final String labelBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _EventDetailsPageState.border),
        boxShadow: const [
          BoxShadow(color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_EventDetailsPageState.grad1, _EventDetailsPageState.grad2],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(labelTop,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12)),
                if (labelBottom.isNotEmpty)
                  Text(labelBottom,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Color(0xFF7A8190), fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _EventDetailsPageState.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_EventDetailsPageState.grad1, _EventDetailsPageState.grad2],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2B2F3A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// --------- CÂMERA (mock) ---------
/// Substitua depois por um fluxo com `camera`/`image_picker`.
class CameraMockPage extends StatelessWidget {
  const CameraMockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Câmera', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          const Center(
            child: Icon(Icons.camera_alt, size: 120, color: Colors.white24),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: GestureDetector(
                onTap: () async {
                  // simula “capturar”
                  await Future.delayed(const Duration(milliseconds: 500));
                  Navigator.pop(context); // volta para a tela anterior
                },
                child: Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(colors: [
                      _EventDetailsPageState.grad1,
                      _EventDetailsPageState.grad2
                    ]),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x55FF135E),
                        blurRadius: 18,
                        offset: Offset(0, 6),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
