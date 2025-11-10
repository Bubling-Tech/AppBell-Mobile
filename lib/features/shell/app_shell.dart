import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/palette.dart';
import '../../shared_widgets/gradient_fab.dart';
import '../events/events_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../ranking/ranking_page.dart';

class AppShellController {
  AppShellController();

  final ValueNotifier<int> tabIndex = ValueNotifier<int>(2);

  void select(int index) => tabIndex.value = index;
}

final AppShellController appShellController = AppShellController();

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => AppShellState();
}

class AppShellState extends State<AppShell> {
  final _pages = const [
    HomePage(),
    RankingPage(),
    EventsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: appShellController.tabIndex,
        builder: (context, index, _) {
          return Scaffold(
            body: IndexedStack(index: index, children: _pages),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Transform.translate(
              offset: const Offset(0, 20),
              child: GradientFab(onTap: () => appShellController.select(0)),
            ),
            bottomNavigationBar: _BottomBar(
              index: index,
              onSelect: (value) => appShellController.select(value),
            ),
          );
        },
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.index, required this.onSelect});

  final int index;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    const double barHeight = 60;
    const double tabHeight = 44;
    const double fabGap = 56;

    return BottomAppBar(
      elevation: 0,
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 4),
        child: SizedBox(
          height: barHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _TabButton(
                icon: Symbols.home,
                label: 'Home',
                selected: index == 0,
                onTap: () => onSelect(0),
              ),
              _TabButton(
                icon: Symbols.trophy_rounded,
                label: 'Ranking',
                selected: index == 1,
                onTap: () => onSelect(1),
              ),
              const SizedBox(width: fabGap),
              _TabButton(
                icon: Symbols.event,
                label: 'Eventos',
                selected: index == 2,
                onTap: () => onSelect(2),
              ),
              _TabButton(
                icon: Symbols.person,
                label: 'Perfil',
                selected: index == 3,
                onTap: () => onSelect(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? Palette.primaryPink : Palette.bottomBarUnselected;
    final fw = selected ? FontWeight.w600 : FontWeight.w400;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        height: 44,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22, weight: 600, fill: selected ? 1 : 0),
            const SizedBox(height: 3),
            Text(
              label,
              textScaleFactor: 1.0,
              style: TextStyle(
                color: color,
                fontSize: 11,
                height: 1.0,
                fontWeight: fw,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
