import 'dart:async';

import 'package:to_com_bell_app/core/mock/mock_data.dart';
import 'package:to_com_bell_app/features/eventos/models/evento.dart';
import 'package:to_com_bell_app/features/eventos/models/filtro_evento.dart';

class EventosService {
  EventosService({List<Evento>? eventos})
      : _eventos = List<Evento>.unmodifiable(eventos ?? mockEventos);

  final List<Evento> _eventos;

  Future<List<Evento>> listarProximos() async {
    final now = DateTime.now();
    final proximos = _eventos
        .where((evento) => !evento.data.isBefore(now))
        .toList()
      ..sort((a, b) => a.data.compareTo(b.data));
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => proximos.take(5).toList(),
    );
  }

  Future<List<Evento>> buscarTodos({FiltroEvento? filtro}) async {
    Iterable<Evento> resultado = _eventos;
    if (filtro != null) {
      if (filtro.uf != null && filtro.uf!.isNotEmpty) {
        resultado = resultado.where(
          (evento) => evento.estado.toUpperCase() == filtro.uf!.toUpperCase(),
        );
      }
      if (filtro.mes != null) {
        resultado = resultado.where((evento) => evento.data.month == filtro.mes);
      }
    }
    final lista = resultado.toList()
      ..sort((a, b) => a.data.compareTo(b.data));
    return Future.delayed(const Duration(milliseconds: 180), () => lista);
  }

  Future<Evento> buscarPorId(String id) async {
    final evento = _eventos.firstWhere((item) => item.id == id);
    return Future.delayed(const Duration(milliseconds: 160), () => evento);
  }
}
