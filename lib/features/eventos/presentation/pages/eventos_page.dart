import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
import 'package:to_com_bell_app/core/utils/result.dart';
import 'package:to_com_bell_app/features/checkin/presentation/widgets/checkin_modal.dart';
import 'package:to_com_bell_app/features/eventos/controllers/eventos_controller.dart';
import 'package:to_com_bell_app/features/eventos/models/evento.dart';
import 'package:to_com_bell_app/features/eventos/models/filtro_evento.dart';
import 'package:to_com_bell_app/features/eventos/presentation/widgets/event_card.dart';
import 'package:to_com_bell_app/features/eventos/presentation/widgets/event_list_item.dart';
import 'package:to_com_bell_app/features/eventos/presentation/widgets/filtro_bottom_sheet.dart';
import 'package:to_com_bell_app/features/eventos/services/eventos_service.dart';
import 'package:to_com_bell_app/features/feed/widgets/app_shell.dart';
import 'package:to_com_bell_app/routes/app_routes.dart';

class EventosPage extends StatefulWidget {
  const EventosPage({super.key});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  late final EventosController controller;

  @override
  void initState() {
    super.initState();
    controller = EventosController(EventosService());
    controller.carregarEventos();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _abrirFiltro() async {
    final filtro = await FiltroBottomSheet.show(
      context,
      filtroAtual: controller.filtroAtual,
    );
    if (!mounted || filtro == null) return;
    await controller.aplicarFiltro(filtro);
  }

  void _irParaDetalhe(String id) {
    Navigator.of(context).pushNamed(AppRoutes.eventoDetalhe(id));
  }

  Future<void> _abrirCheckin() => CheckinModal.show(context);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return AppShell(
          current: BottomNavItem.eventos,
          onCameraPressed: _abrirCheckin,
          appBar: AppBar(
            titleSpacing: 24,
            title: const Text('Próximos shows'),
            actions: [
              TextButton(
                onPressed: () => controller.aplicarFiltro(const FiltroEvento()),
                child: const Text('Veja mais'),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: controller.carregarEventos,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarrossel(),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Text(
                          'Todos os eventos',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: _abrirFiltro,
                          tooltip: 'Aplicar filtros',
                          icon: const Icon(Icons.tune_rounded),
                        ),
                      ],
                    ),
                  ),
                  _buildListaEventos(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCarrossel() {
    final estado = controller.proximos;
    if (estado.status == ResultStatus.loading) {
      return const SizedBox(
        height: 320,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (estado.status == ResultStatus.error) {
      return _MensagemEstado(
        mensagem: estado.message ?? 'Não foi possível carregar os eventos.',
      );
    }
    final lista = estado.data ?? const <Evento>[];
    if (lista.isEmpty) {
      return _MensagemEstado(
        mensagem: estado.message ?? 'Nenhum evento encontrado no momento.',
      );
    }
    return SizedBox(
      height: 320,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final evento = lista[index];
          return EventCard(
            evento: evento,
            onTap: () => _irParaDetalhe(evento.id),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: lista.length,
      ),
    );
  }

  Widget _buildListaEventos() {
    final estado = controller.todos;
    if (estado.status == ResultStatus.loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 56),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (estado.status == ResultStatus.error) {
      return _MensagemEstado(
        mensagem: estado.message ?? 'Não foi possível carregar os eventos.',
      );
    }
    final lista = estado.data ?? const <Evento>[];
    if (lista.isEmpty) {
      return _MensagemEstado(
        mensagem: estado.message ?? 'Nenhum evento encontrado com esse filtro.',
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lista.length,
      padding: const EdgeInsets.only(bottom: 120),
      separatorBuilder: (_, __) => const Divider(
        indent: 24,
        endIndent: 24,
        height: 0,
        color: AppColors.border,
      ),
      itemBuilder: (context, index) {
        final evento = lista[index];
        return EventListItem(
          evento: evento,
          onTap: () => _irParaDetalhe(evento.id),
        );
      },
    );
  }
}

class _MensagemEstado extends StatelessWidget {
  const _MensagemEstado({required this.mensagem});

  final String mensagem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            mensagem,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textMedium),
          ),
        ),
      ),
    );
  }
}
