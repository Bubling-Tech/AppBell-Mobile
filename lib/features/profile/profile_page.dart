import 'package:flutter/material.dart';

import '../../core/palette.dart';
import '../../data/mocks/service_locator.dart';
import '../../domain/models/user_profile.dart';
import '../../routes/app_router.dart';
import '../../shared_widgets/gradient_button.dart';
import '../../shared_widgets/stat_chip.dart';
import 'widgets/spotify_chip.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  late Future<UserProfile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = SL.profile.getProfile();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<UserProfile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final profile = snapshot.data!;
          final width = MediaQuery.of(context).size.width;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        profile.bannerUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(profile.avatarUrl),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
                  child: Column(
                    children: [
                      Text(
                        profile.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        profile.bio,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Palette.textSoft,
                          fontSize: 13.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _IconTextChip(
                            icon: Icons.place,
                            text: profile.cityState,
                          ),
                          SpotifyChip(song: profile.spotifySong),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: StatChip(
                              badgeText: profile.stats.rankPosition,
                              title: 'Ranking atual',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatChip(
                              badgeText: profile.stats.checkins,
                              title: 'Check-ins realizados',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                      final post = profile.posts[index];
                      return _EventCard(post: post);
                    },
                    childCount: profile.posts.length,
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
          );
        },
      ),
    );
  }

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
                GradientButton(
                  text: 'Sair',
                  height: 48,
                  borderRadius: BorderRadius.circular(12),
                  onPressed: () {
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abrir edição de perfil')),
    );
  }

  void _onChangePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abrir troca de senha')),
    );
  }

  void _onSignOut() {
    goHome(context);
  }
}

const double _avatarSize = 96;

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
        decoration: const BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _SheetTile extends StatelessWidget {
  const _SheetTile({required this.icon, required this.title, required this.onTap});

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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      visualDensity: const VisualDensity(horizontal: -1, vertical: -1),
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
        color: Palette.backgroundSoft,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Palette.borderChip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF9AA3B2)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 12.5, color: Palette.textSoft),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.post});

  final UserPost post;

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
              child: Image.network(post.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                post.title,
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
                post.city,
                style: const TextStyle(
                  color: Palette.textSoft,
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
