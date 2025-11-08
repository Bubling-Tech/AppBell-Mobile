import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // Paleta
  static const Color _grad1 = Color(0xFFFF5125);
  static const Color _grad2 = Color(0xFFFF135E);
  static const Color _softText = Color(0xFF6B7280);
  static const Color _chipBorder = Color(0xFFE8ECF3);
  static const double _avatarSize = 96;

  // Mocks
  final List<Map<String, String>> _cards = List.generate(4, (i) {
    final titles = ['PreCaju 2024', 'PreCaju 2025'];
    final cities = ['Aracaju-SE', 'Aracaju-SE'];
    final imgs = [
      'https://images.unsplash.com/photo-1541470074078-4f9a1e3d4d3f?q=80&w=1200&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1487180144351-b8472da7d491?q=80&w=1200&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1541470074078-4f9a1e3d4d3f?q=80&w=1200&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1487180144351-b8472da7d491?q=80&w=1200&auto=format&fit=crop',
    ];
    return {
      'title': titles[i % 2],
      'city': cities[i % 2],
      'img': imgs[i],
    };
  });

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Capa + avatar + ícone de configurações
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=1600&auto=format&fit=crop',
                    fit: BoxFit.cover,
                  ),
                ),

                // Botões no topo (config e voltar opcional)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Row(
                      children: [
                        _CircleTopButton(
                          icon: Icons.arrow_back,
                          onTap: () => Navigator.maybePop(context),
                        ),
                        const Spacer(),
                        _CircleTopButton(
                          icon: Icons.settings_outlined,
                          onTap: _openSettingsSheet,
                        ),
                      ],
                    ),
                  ),
                ),

                // Avatar central
                Positioned(
                  left: (width - _avatarSize) / 2,
                  bottom: -(_avatarSize / 2),
                  child: Container(
                    width: _avatarSize,
                    height: _avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=800&auto=format&fit=crop',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Conteúdo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
              child: Column(
                children: [
                  const Text(
                    'Matheus Ferreira',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Advogado e produtor de conteúdo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _softText,
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Chips: localização + Spotify
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _IconTextChip(
                        icon: Icons.place,
                        text: 'Localização atual - Aracaju/SE',
                      ),
                      _SpotifyChip(song: '“Mares do Sul” - Djavan'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Estatísticas
                  Row(
                    children: const [
                      Expanded(
                        child: _StatCard(
                          badgeText: '#14',
                          title: 'Ranking atual',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          badgeText: '20',
                          title: 'Check-ins realizados',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Grid de eventos/publicações
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (ctx, i) {
                  final e = _cards[i];
                  return _EventCard(
                    title: e['title']!,
                    city: e['city']!,
                    imgUrl: e['img']!,
                  );
                },
                childCount: _cards.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ====================== Settings Sheet ======================

  void _openSettingsSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SheetTile(
                  icon: Icons.person_outline,
                  title: 'Editar perfil',
                  onTap: () {
                    Navigator.pop(ctx);
                    _onEditProfile();
                  },
                ),
                const Divider(height: 1),
                _SheetTile(
                  icon: Icons.lock_reset_outlined,
                  title: 'Trocar senha',
                  onTap: () {
                    Navigator.pop(ctx);
                    _onChangePassword();
                  },
                ),
                const Divider(height: 1),
                const SizedBox(height: 8),
                _GradientActionButton(
                  text: 'Sair',
                  onTap: () {
                    Navigator.pop(ctx);
                    _onSignOut();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onEditProfile() {
    // TODO: Navegar para tela de edição de perfil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abrir edição de perfil')),
    );
  }

  void _onChangePassword() {
    // TODO: Abrir fluxo de troca de senha
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abrir troca de senha')),
    );
  }

  void _onSignOut() {
    // TODO: limpar sessão e redirecionar para login
    Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
  }
}

/// ---------- Widgets auxiliares (UI) ----------

class _CircleTopButton extends StatelessWidget {
  const _CircleTopButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _SheetTile extends StatelessWidget {
  const _SheetTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Icon(icon, color: const Color(0xFF3B4252)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      visualDensity: const VisualDensity(horizontal: -1, vertical: -1),
    );
  }
}

class _GradientActionButton extends StatelessWidget {
  const _GradientActionButton({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_ProfilePageState._grad1, _ProfilePageState._grad2],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x25000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Sair',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconTextChip extends StatelessWidget {
  const _IconTextChip({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _ProfilePageState._chipBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF9AA3B2)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 12.5, color: _ProfilePageState._softText),
          ),
        ],
      ),
    );
  }
}

class _SpotifyChip extends StatelessWidget {
  const _SpotifyChip({required this.song});
  final String song;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1DB954).withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFF1DB954).withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.music_note, color: Color(0xFF1DB954), size: 16),
          const SizedBox(width: 6),
          Text(
            song,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1DB954),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.badgeText, required this.title});
  final String badgeText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _ProfilePageState._chipBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_ProfilePageState._grad1, _ProfilePageState._grad2],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33FF135E),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                badgeText,
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
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({
    required this.title,
    required this.city,
    required this.imgUrl,
  });

  final String title;
  final String city;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.network(imgUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                city,
                style: const TextStyle(
                  color: _ProfilePageState._softText,
                  fontSize: 12.5,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
