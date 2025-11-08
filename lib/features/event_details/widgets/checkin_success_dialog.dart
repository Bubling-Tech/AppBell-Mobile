import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import '../../../shared_widgets/gradient_button.dart';

class CheckinSuccessDialog extends StatelessWidget {
  const CheckinSuccessDialog({super.key, required this.onPrimary});

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
                GradientButton(
                  text: 'VAMOS LÁ, POSTE E CURTA!',
                  onPressed: onPrimary,
                  height: 48,
                  borderRadius: BorderRadius.circular(12),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                  boxShadow: const [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PinPulse extends StatefulWidget {
  const _PinPulse();

  @override
  State<_PinPulse> createState() => _PinPulseState();
}

class _PinPulseState extends State<_PinPulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ScaleTransition(
          scale: Tween(begin: 0.85, end: 1.05).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          ),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEFEF),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Palette.primaryPink.withOpacity(0.25),
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
              colors: [Palette.primaryOrange, Palette.primaryPink],
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
