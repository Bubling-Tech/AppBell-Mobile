import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/gradients.dart';

enum CheckinStatus { loading, success, error }

class CheckinState {
  const CheckinState._(this.status, this.message);

  const CheckinState.loading(String message) : this._(CheckinStatus.loading, message);
  const CheckinState.success(String message) : this._(CheckinStatus.success, message);
  const CheckinState.error(String message) : this._(CheckinStatus.error, message);

  final CheckinStatus status;
  final String message;
}

class CheckinDialog extends StatelessWidget {
  const CheckinDialog({
    super.key,
    required this.states,
    required this.onRetry,
    required this.onCancel,
    required this.onSuccess,
  });

  final Stream<CheckinState> states;
  final VoidCallback onRetry;
  final VoidCallback onCancel;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: StreamBuilder<CheckinState>(
        stream: states,
        initialData: const CheckinState.loading('Verificando sua localização...'),
        builder: (context, snapshot) {
          final state = snapshot.data!;

          if (state.status == CheckinStatus.success) {
            Future.microtask(onSuccess);
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DialogHeaderIcon(status: state.status),
                const SizedBox(height: 12),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, height: 1.35),
                ),
                const SizedBox(height: 16),
                if (state.status == CheckinStatus.loading)
                  const _LoadingBar()
                else
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
                          onPressed: onCancel,
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                            backgroundColor: const Color(0xFFFF135E),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: onRetry,
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
  }
}

class _DialogHeaderIcon extends StatelessWidget {
  const _DialogHeaderIcon({required this.status});

  final CheckinStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case CheckinStatus.loading:
        return Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: AppGradients.primaryDiagonal,
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
      case CheckinStatus.success:
        return const SizedBox.shrink();
      case CheckinStatus.error:
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
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF135E)),
            ),
          ),
        ),
      ],
    );
  }
}
