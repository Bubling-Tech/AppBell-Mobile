import 'package:flutter/material.dart';

import '../../EventDetailsPage.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // -------------------- MOCKS --------------------
  // Destaques (carrossel) — com coords para check-in
  final List<Map<String, dynamic>> _featured = [
    {
      'titulo': 'Bloco Vumbora',
      'local': 'Salvador, Bahia - Brasil',
      'dataCurta': '05 DE FEV',
      'data': '05 de fevereiro de 2025',
      'img':
      'https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?q=80&w=1200&auto=format&fit=crop',
      'lat': -12.9777,
      'lng': -38.5016,
      'checkins': 120,
      'pubs': 45,
      'palco': 'Palco Barra',
      'desc':
      'O Bloco Vumbora é um dos maiores e mais animados blocos de rua.',
    },
    {
      'titulo': 'Bloco do Camaleão',
      'local': 'Recife, Pernambuco - Brasil',
      'dataCurta': '12 DE FEV',
      'data': '12 de fevereiro de 2025',
      'img':
      'https://images.unsplash.com/photo-1469461084727-4bfb496cf55a?q=80&w=1200&auto=format&fit=crop',
      'lat': -8.0543,
      'lng': -34.8813,
      'checkins': 88,
      'pubs': 30,
      'palco': 'Marco Zero',
      'desc':
      'O Camaleão arrasta multidões com muito axé e energia contagiante.',
    },
  ];

  // Lista completa (com data e coords)
  final List<Map<String, dynamic>> _all = List.generate(12, (i) {
    final names = [
      'Bloco Vumbora',
      'Bloco do Camaleão',
      'Bloco dos Namorados',
      'Bloco Alegria Geral',
      'Bloco Axé Folia'
    ];
    final cities = [
      'Salvador, Bahia - Brasil',
      'Recife, Pernambuco - Brasil',
      'João Pessoa, Paraíba - Brasil',
      'Fortaleza, Ceará - Brasil',
      'Maceió, Alagoas - Brasil',
    ];
    final imgs = [
      'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1200&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=1200&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1506157786151-b8491531f063?q=80&w=1200&auto=format&fit=crop',
    ];
    final datas = [
      '03 de fevereiro de 2025',
      '05 de fevereiro de 2025',
      '12 de março de 2025',
      '18 de abril de 2025',
      '27 de fevereiro de 2025',
      '10 de março de 2025',
    ];
    // coords simples por cidade (mock)
    final coords = {
      'Salvador, Bahia - Brasil': const Offset(-12.9777, -38.5016),
      'Recife, Pernambuco - Brasil': const Offset(-8.0543, -34.8813),
      'João Pessoa, Paraíba - Brasil': const Offset(-7.1195, -34.8450),
      'Fortaleza, Ceará - Brasil': const Offset(-3.7319, -38.5267),
      'Maceió, Alagoas - Brasil': const Offset(-9.6498, -35.7089),
    };
    final local = cities[i % cities.length];
    final off = coords[local] ?? const Offset(-9.6498, -35.7089);

    return {
      'titulo': names[i % names.length],
      'local': local,
      'img': imgs[i % imgs.length],
      'data': datas[i % datas.length],
      'lat': off.dx,
      'lng': off.dy,
      'checkins': 20 + (i * 3),
      'pubs': 5 + i,
      'palco': 'Palco Principal',
      'desc':
      'Evento imperdível com trio elétrico e atrações ao vivo para toda a família.',
    };
  });

  // -------------------- FILTROS --------------------
  String? _fEstado;
  String? _fMes;

  static const List<String> _meses = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  String _estadoDe(String local) {
    final p = local.split(',');
    if (p.length < 2) return local;
    var est = p[1].trim();
    if (est.endsWith(' - Brasil')) {
      est = est.substring(0, est.length - ' - Brasil'.length);
    }
    return est;
    // ex: "Recife, Pernambuco - Brasil" -> "Pernambuco"
  }

  String? _mesDe(String? data) {
    if (data == null) return null;
    final l = data.toLowerCase();
    for (final m in _meses) {
      if (l.contains(m.toLowerCase())) return m;
    }
    return null;
  }

  List<Map<String, dynamic>> get _filteredAll {
    return _all.where((e) {
      final okEstado = _fEstado == null || _estadoDe(e['local']) == _fEstado;
      final okMes = _fMes == null || _mesDe(e['data']) == _fMes;
      return okEstado && okMes;
    }).toList();
  }

  // -------------------- Navegação c/ Hero --------------------
  void _openDetails(Map<String, dynamic> e) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventDetailsPage(
          titulo: e['titulo'] as String,
          local: e['local'] as String,
          dataHora: (e['data'] as String?) ?? (e['dataCurta'] as String? ?? ''),
          imgUrl: e['img'] as String,
          heroTag: e['img'] as String, // mesma tag usada no card
          latitude: (e['lat'] as num).toDouble(),
          longitude: (e['lng'] as num).toDouble(),
          checkins: (e['checkins'] as int?) ?? 0,
          publicacoes: (e['pubs'] as int?) ?? 0,
          palco: (e['palco'] as String?) ?? 'Palco',
          descricao: (e['desc'] as String?) ??
              'Descrição breve do evento. Edite este texto de acordo com o seu conteúdo.',
        ),
      ),
    );
  }

  // -------------------- Bottom Sheet Filtros (igual ao seu) --------------------
  void _openFilters() {
    final estados = {for (final e in _all) _estadoDe(e['local'] as String)}
        .toList()
      ..sort();

    String? selEstado = _fEstado;
    String? selMes = _fMes;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.35),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final bottom = MediaQuery.of(ctx).viewInsets.bottom;
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 16 + bottom),
            child: StatefulBuilder(
              builder: (ctx, setLocal) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 56,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7E9EE),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const _FieldLabel('Estado:'),
                    _DropdownField(
                      hint: 'Selecione um estado',
                      items: estados
                          .map((uf) => DropdownMenuItem(
                        value: uf,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 5,
                              backgroundColor: Color(0xFF0ACF83),
                            ),
                            const SizedBox(width: 8),
                            Text(uf),
                          ],
                        ),
                      ))
                          .toList(),
                      value: selEstado,
                      onChanged: (v) => setLocal(() => selEstado = v),
                    ),

                    const SizedBox(height: 18),
                    const _FieldLabel('Mês:'),
                    _DropdownField(
                      hint: 'Selecione o mês',
                      items: _meses
                          .map((m) => DropdownMenuItem(
                        value: m,
                        child: Text(m),
                      ))
                          .toList(),
                      value: selMes,
                      onChanged: (v) => setLocal(() => selMes = v),
                    ),

                    const SizedBox(height: 18),
                    const Divider(height: 1, color: Color(0xFFE7EBF3)),
                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: _OutlineNiceButton(
                            text: 'RESETAR',
                            onPressed: () {
                              setState(() {
                                _fEstado = null;
                                _fMes = null;
                              });
                              Navigator.pop(ctx);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _PrimaryGradientButton(
                            text: 'APLICAR FILTROS',
                            onPressed: () {
                              setState(() {
                                _fEstado = selEstado;
                                _fMes = selMes;
                              });
                              Navigator.pop(ctx);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  // -------------------- UI --------------------
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Topo: busca
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                    const Spacer(),
                  ],
                ),
              ),
            ),

            // Próximos shows
            SliverToBoxAdapter(
              child: _SectionHeader(
                title: 'Próximos shows',
                actionText: 'Veja mais',
                onAction: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 210,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: _featured.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) {
                    final item = _featured[i];
                    return GestureDetector(
                      onTap: () => _openDetails(item),
                      child: _FeaturedCard(
                        item: item,
                        heroTag: item['img'] as String,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Todos os eventos
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
                child: Row(
                  children: [
                    const Text(
                      'Todos os eventos',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _openFilters,
                      icon: const Icon(Icons.filter_list_rounded),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverList.separated(
                itemCount: _filteredAll.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final item = _filteredAll[i];
                  return GestureDetector(
                    onTap: () => _openDetails(item),
                    child: _EventPill(
                      item: item,
                      heroTag: item['img'] as String,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------- Widgets auxiliares

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionText, this.onAction});
  final String title;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const Spacer(),
          if (actionText != null)
            TextButton(
              onPressed: onAction,
              child: Text(
                actionText!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF135E),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.item, required this.heroTag});
  final Map<String, dynamic> item;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 6))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // HERO na imagem
            Positioned.fill(
              child: Hero(
                tag: heroTag,
                child: Image.network(item['img'] as String, fit: BoxFit.cover),
              ),
            ),
            // Overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.05),
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
            ),
            // Badge data
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0ACF83),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  (item['dataCurta'] as String?) ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
            // Conteúdo
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['titulo'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['local'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const _GradientButton(text: 'SAIBA MAIS'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventPill extends StatelessWidget {
  const _EventPill({required this.item, required this.heroTag});
  final Map<String, dynamic> item;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Hero(
              tag: heroTag,
              child: Image.network(
                item['img'] as String,
                width: 86,
                height: 86,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // textos
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['titulo'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['local'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF7A8190),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  (item['data'] as String?) ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF7A8190),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF7A8190)),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: GestureDetector(
        onTap: onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF5125), Color(0xFFFF135E)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 3)),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1D2630),
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final String hint;
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7EBF3)),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                hint: Text(hint, style: const TextStyle(color: Color(0xFF9AA3B2))),
                items: items,
                onChanged: onChanged,
                icon: const SizedBox.shrink(), // esconde o ícone padrão
              ),
            ),
          ),
          const SizedBox(width: 8),
          // “pill” do ícone à direita
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF3F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.expand_more, color: Color(0xFF7A8190)),
          ),
        ],
      ),
    );
  }
}

class _OutlineNiceButton extends StatelessWidget {
  const _OutlineNiceButton({required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        side: const BorderSide(color: Color(0xFFE0E5EC), width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        foregroundColor: const Color(0xFF2D3340),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
      child: Text(text),
    );
  }
}

class _PrimaryGradientButton extends StatelessWidget {
  const _PrimaryGradientButton({required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF5125), Color(0xFFFF135E)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Color(0x26000000), blurRadius: 10, offset: Offset(0, 4)),
          ],
        ),
        child: const Center(
          child: Text(
            'APLICAR FILTROS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
