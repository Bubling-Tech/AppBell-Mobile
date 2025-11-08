import 'package:flutter/material.dart';

import '../../../core/gradients.dart';
import '../../../shared_widgets/gradient_button.dart';

class CheckinSuccessDialog extends StatelessWidget {
  const CheckinSuccessDialog({super.key, this.onConfirm});

  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                gradient: AppGradients.primaryDiagonal,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33FF135E),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.bolt_rounded,
                color: Colors.white,
                size: 42,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Sua energia chegou junto com você!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF111418),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Agora é hora de compartilhar o momento — poste e curta o evento!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1200&auto=format&fit=crop',
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            GradientButton(
              text: 'POSTE E CURTA',
              height: 50,
              borderRadius: BorderRadius.circular(14),
              onPressed: () {
                Navigator.pop(context);
                onConfirm?.call();
              },
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
              boxShadow: const [],
            ),
          ],
        ),
      ),
    );
  }
}
