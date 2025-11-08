import 'package:flutter/foundation.dart';
import 'package:to_com_bell_app/core/utils/result.dart';
import 'package:to_com_bell_app/features/eventos/models/evento.dart';
import 'package:to_com_bell_app/features/eventos/models/filtro_evento.dart';
import 'package:to_com_bell_app/features/eventos/services/eventos_service.dart';

class EventosController extends ChangeNotifier {
  EventosController(this._service);

  final EventosService _service;

  Result<List<Evento>> proximos = Result.loading();
  Result<List<Evento>> todos = Result.loading();
  FiltroEvento filtroAtual = const FiltroEvento();

  Future<void> carregarEventos() async {
    await Future.wait([_carregarProximos(), _carregarTodos()]);
  }

  Future<void> _carregarProximos() async {
    proximos = Result.loading();
    notifyListeners();
    try {
      final lista = await _service.listarProximos();
      proximos = lista.isEmpty
          ? Result.empty(message: 'Nenhum evento encontrado.')
          : Result.success(lista);
    } catch (error) {
      proximos = Result.error('Não foi possível carregar os eventos.');
    }
    notifyListeners();
  }

  Future<void> _carregarTodos() async {
    todos = Result.loading();
    notifyListeners();
    try {
      final lista = await _service.buscarTodos(filtro: filtroAtual);
      if (lista.isEmpty) {
        todos = Result.empty(message: 'Nenhum evento com esse filtro.');
      } else {
        todos = Result.success(lista);
      }
    } catch (error) {
      todos = Result.error('Não foi possível carregar os eventos.');
    }
    notifyListeners();
  }

  Future<void> aplicarFiltro(FiltroEvento filtro) async {
    filtroAtual = filtro;
    await _carregarTodos();
  }
}
