import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/utils/result.dart';
import 'package:to_com_bell_app/features/checkin/presentation/widgets/checkin_modal.dart';
import 'package:to_com_bell_app/features/eventos/controllers/eventos_controller.dart';
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

  Future<void> _abrirCheckin() async {
    await CheckinModal.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return AppShell(
          current: BottomNavItem.eventos,
          onCameraPressed: _abrirCheckin,
          appBar: AppBar(
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarrossel(theme),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text('Todos os eventos',
                            style: theme.textTheme.titleMedium),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.filter_list_rounded),
                          tooltip: 'Aplicar filtros',
                          onPressed: _abrirFiltro,
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

  Widget _buildCarrossel(ThemeData theme) {
    final estado = controller.proximos;
    if (estado.status == ResultStatus.loading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (estado.status == ResultStatus.error) {
      return _MensagemErro(mensagem: estado.message!);
    }
    if (estado.status == ResultStatus.empty || estado.data?.isEmpty == true) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text('Nenhum evento encontrado.'),
      );
    }
    return SizedBox(
      height: 320,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final evento = estado.data![index];
          return EventCard(
            evento: evento,
            onTap: () => _irParaDetalhe(evento.id),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: estado.data!.length,
      ),
    );
  }

  Widget _buildListaEventos() {
    final estado = controller.todos;
    if (estado.status == ResultStatus.loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (estado.status == ResultStatus.error) {
      return _MensagemErro(mensagem: estado.message!);
    }
    if (estado.status == ResultStatus.empty || estado.data?.isEmpty == true) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Text('Nenhum evento com esse filtro.'),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: estado.data!.length,
      itemBuilder: (context, index) {
        final evento = estado.data![index];
        return EventListItem(
          evento: evento,
          onTap: () => _irParaDetalhe(evento.id),
        );
      },
    );
  }
}

class _MensagemErro extends StatelessWidget {
  const _MensagemErro({required this.mensagem});

  final String mensagem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(mensagem),
        ),
      ),
    );
  }
}
