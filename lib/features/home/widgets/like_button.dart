import 'package:flutter/material.dart';

import '../../../core/palette.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key, required this.isLiked, required this.onChanged});

  final bool isLiked;
  final ValueChanged<bool> onChanged;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {
  late bool _liked = widget.isLiked;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 180),
  );

  late final Animation<double> _iconScale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(begin: 1.0, end: 1.25).chain(CurveTween(curve: Curves.easeInOutBack)),
      weight: 60,
    ),
    TweenSequenceItem(
      tween: Tween(begin: 1.25, end: 1.0).chain(CurveTween(curve: Curves.easeInCubic)),
      weight: 40,
    ),
  ]).animate(_controller);

  late final Animation<double> _pulseRadius = Tween<double>(begin: 0, end: 20)
      .chain(CurveTween(curve: Curves.easeOut))
      .animate(_controller);

  late final Animation<double> _pulseOpacity = Tween<double>(begin: 0.45, end: 0)
      .chain(CurveTween(curve: Curves.easeOut))
      .animate(_controller);

  void _toggle() {
    setState(() => _liked = !_liked);
    widget.onChanged(_liked);
    if (_liked) {
      _controller.forward(from: 0);
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (_controller.value > 0)
                Opacity(
                  opacity: _pulseOpacity.value,
                  child: Container(
                    width: 36 + _pulseRadius.value,
                    height: 36 + _pulseRadius.value,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.likePulse,
                    ),
                  ),
                ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _liked ? Palette.likePulse : Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: _liked
                      ? [
                          BoxShadow(
                            color: Palette.likePulse.withOpacity(0.35),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
                child: ScaleTransition(
                  scale: _iconScale,
                  child: Icon(
                    _liked ? Icons.celebration : Icons.celebration_outlined,
                    color: _liked ? Colors.white : Palette.likePulse,
                    size: 26,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
