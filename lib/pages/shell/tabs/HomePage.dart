import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  final List<Map<String, dynamic>> _feed = List.generate(6, (i) {
    return {
      'user': 'Usuário ${i + 1}',
      'evento': 'Bloco da Alegria ${i + 1}',
      'img':
      'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=900&q=80',
    };
  });

  // controle das curtidas
  final Map<int, bool> _liked = {};

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _feed.length,
        itemBuilder: (context, index) {
          final post = _feed[index];
          final isLiked = _liked[index] ?? false;
          return _buildPost(context, post, index, isLiked);
        },
      ),
    );
  }

  Widget _buildPost(
      BuildContext context, Map<String, dynamic> post, int index, bool isLiked) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // imagem principal
        Image.network(post['img'], fit: BoxFit.cover),

        // gradiente para leitura
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
              ],
            ),
          ),
        ),

        // conteúdo sobreposto à esquerda (dados)
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage:
                    NetworkImage('https://i.pravatar.cc/100?img=5'),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['user'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        post['evento'],
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),

        // botão curtir flutuante à direita
        Positioned(
          right: 20,
          bottom: 40,
          child: _IconLikeButton(
            isLiked: isLiked,
            onChanged: (val) => setState(() => _liked[index] = val),
          ),
        ),
      ],
    );
  }
}

/// botão curtir com animação de "pop" + pulso circular
class _IconLikeButton extends StatefulWidget {
  final bool isLiked;
  final ValueChanged<bool> onChanged;

  const _IconLikeButton({
    required this.isLiked,
    required this.onChanged,
  });

  @override
  State<_IconLikeButton> createState() => _IconLikeButtonState();
}

class _IconLikeButtonState extends State<_IconLikeButton>
    with SingleTickerProviderStateMixin {
  late bool _liked = widget.isLiked;

  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 180),
  );

  // animação combinada
  late final Animation<double> _iconScale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(begin: 1.0, end: 1.25).chain(CurveTween(curve: Curves.easeInOutBack)),
      weight: 60,
    ),
    TweenSequenceItem(
      tween: Tween(begin: 1.25, end: 1.0).chain(CurveTween(curve: Curves.easeInCubic)),
      weight: 40,
    ),
  ]).animate(_c);

  late final Animation<double> _pulseRadius = Tween<double>(begin: 0, end: 20)
      .chain(CurveTween(curve: Curves.easeOut))
      .animate(_c);
  late final Animation<double> _pulseOpacity = Tween<double>(begin: 0.45, end: 0)
      .chain(CurveTween(curve: Curves.easeOut))
      .animate(_c);

  void _toggle() {
    setState(() => _liked = !_liked);
    widget.onChanged(_liked);
    if (_liked) {
      _c.forward(from: 0);
    } else {
      _c.reverse();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color likeColor = Color(0xFFFF135E);
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // pulso circular atrás
              if (_c.value > 0)
                Opacity(
                  opacity: _pulseOpacity.value,
                  child: Container(
                    width: 36 + _pulseRadius.value,
                    height: 36 + _pulseRadius.value,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: likeColor,
                    ),
                  ),
                ),

              // ícone curtir
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _liked ? likeColor : Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: _liked
                      ? [
                    BoxShadow(
                      color: likeColor.withOpacity(0.35),
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
                    color: _liked ? Colors.white : likeColor,
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
