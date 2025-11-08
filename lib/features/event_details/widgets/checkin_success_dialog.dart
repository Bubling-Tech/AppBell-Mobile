import 'package:flutter/material.dart';

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
      child: Material(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(_illustrationUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Check-in confirmado!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111418),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Agora é só registrar esse momento incrível. Faça uma foto e compartilhe com a galera!',
                    style: TextStyle(fontSize: 14, height: 1.45, color: Color(0xFF2B2F3A)),
                  ),
                  const SizedBox(height: 18),
                  GradientButton(
                    text: 'VAMOS LÁ, POSTE E CURTA!',
                    onPressed: onPrimary,
                    height: 52,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
