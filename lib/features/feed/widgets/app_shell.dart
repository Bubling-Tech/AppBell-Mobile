import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
import 'package:to_com_bell_app/routes/app_routes.dart';

enum BottomNavItem { feed, ranking, eventos, perfil }

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    this.appBar,
    required this.body,
    required this.current,
    this.onCameraPressed,
    this.padding,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final BottomNavItem current;
  final VoidCallback? onCameraPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final scaffoldBody = padding != null
        ? Padding(padding: padding!, child: body)
        : body;
    return Scaffold(
      appBar: appBar,
      body: scaffoldBody,
      floatingActionButton: FloatingActionButton(
        onPressed: onCameraPressed,
        tooltip: 'Abrir câmera',
        shape: const CircleBorder(),
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.camera_alt_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        color: AppColors.surface,
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 76,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomNavButton(
                  label: 'Home',
                  icon: Icons.home_filled,
                  isSelected: current == BottomNavItem.feed,
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.feed),
                ),
                _BottomNavButton(
                  label: 'Ranking',
                  icon: Icons.emoji_events,
                  isSelected: current == BottomNavItem.ranking,
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.ranking),
                ),
                const SizedBox(width: 60),
                _BottomNavButton(
                  label: 'Eventos',
                  icon: Icons.event,
                  isSelected: current == BottomNavItem.eventos,
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.eventos),
                ),
                _BottomNavButton(
                  label: 'Perfil',
                  icon: Icons.person,
                  isSelected: current == BottomNavItem.perfil,
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.perfil),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavButton extends StatelessWidget {
  const _BottomNavButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textWeak;
    return Semantics(
      label: label,
      button: true,
      selected: isSelected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 72,
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
