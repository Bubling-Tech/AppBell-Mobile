import 'package:flutter/foundation.dart';
import 'package:to_com_bell_app/core/utils/result.dart';
import 'package:to_com_bell_app/features/eventos/models/evento.dart';
import 'package:to_com_bell_app/features/eventos/services/eventos_service.dart';

class EventoDetalheController extends ChangeNotifier {
  EventoDetalheController(this._service);

  final EventosService _service;

  Result<Evento> evento = Result.loading();

  Future<void> carregar(String id) async {
    evento = Result.loading();
    notifyListeners();
    try {
      final dados = await _service.buscarPorId(id);
      evento = Result.success(dados);
    } catch (error) {
      evento = Result.error('Evento não encontrado.');
    }
    notifyListeners();
  }
}
