import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:to_com_bell_app/pages/shell/tabs/EventsPage.dart';
import 'package:to_com_bell_app/pages/shell/tabs/FeedPage.dart';
import 'package:to_com_bell_app/pages/shell/tabs/HomePage.dart';
import 'package:to_com_bell_app/pages/shell/tabs/ProfilePage.dart';
import 'package:to_com_bell_app/pages/shell/tabs/RankingPage.dart';


class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 3; // 0=Home, 1=Ranking, 2=Feed, 3=Eventos, 4=Perfil

  // Paleta
  static const _unselected = Color(0xFF8A8A8E);
  static const _selected = Color(0xFFFF135E);

  final _pages = const [
    HomePage(),
    RankingPage(),
    FeedPage(),
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
      child: Scaffold(
        body: IndexedStack(index: _index, children: _pages),

        // Botão central fixo e rebaixado
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Transform.translate(
          offset: const Offset(0, 20),
          child: _CameraFab(onTap: () => setState(() => _index = 2)),
        ),

        // Barra inferior
        bottomNavigationBar: _BottomBar(
          index: _index,
          onSelect: (i) => setState(() => _index = i),
          unselected: _unselected,
          selected: _selected,
        ),
      ),
    );
  }
}

/// ---------- Barra inferior (4 abas + espaço do FAB)
class _BottomBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onSelect;
  final Color unselected;
  final Color selected;

  const _BottomBar({
    required this.index,
    required this.onSelect,
    required this.unselected,
    required this.selected,
  });

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
                selectedColor: selected,
                unselectedColor: unselected,
                height: tabHeight,
                onTap: () => onSelect(0),
              ),
              _TabButton(
                icon: Symbols.trophy_rounded,
                label: 'Ranking',
                selected: index == 1,
                selectedColor: selected,
                unselectedColor: unselected,
                height: tabHeight,
                onTap: () => onSelect(1),
              ),
              const SizedBox(width: fabGap),
              _TabButton(
                icon: Symbols.event,
                label: 'Eventos',
                selected: index == 3,
                selectedColor: selected,
                unselectedColor: unselected,
                height: tabHeight,
                onTap: () => onSelect(3),
              ),
              _TabButton(
                icon: Symbols.person,
                label: 'Perfil',
                selected: index == 4,
                selectedColor: selected,
                unselectedColor: unselected,
                height: tabHeight,
                onTap: () => onSelect(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Item da aba (compacto e sem overflow)
class _TabButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final double height;

  const _TabButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? selectedColor : unselectedColor;
    final fw = selected ? FontWeight.w600 : FontWeight.w400;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22, weight: 600, fill: selected ? 1 : 0,),
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

/// FAB central com gradiente #FF5125 → #FF135E (ícone de câmera branco)
class _CameraFab extends StatelessWidget {
  final VoidCallback onTap;
  const _CameraFab({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      elevation: 1,
      fillColor: Colors.transparent,
      constraints: const BoxConstraints.tightFor(width: 64, height: 64),
      shape: const CircleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF5125),
              Color(0xFFFF135E),
            ],
          ),
        ),
        child: const Center(
          child: Icon(
              Symbols.photo_camera,
              color: Colors.white,
              size: 26,
              fill: 1,    // opcional: 0..1
              weight: 700 // opcional
          ),
        ),
      ),
    );
  }
}
