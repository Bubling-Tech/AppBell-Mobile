import 'package:flutter/foundation.dart';
import 'package:to_com_bell_app/core/utils/result.dart';
import 'package:to_com_bell_app/features/perfil/models/perfil.dart';
import 'package:to_com_bell_app/features/perfil/services/perfil_service.dart';

class PerfilController extends ChangeNotifier {
  PerfilController(this._service);

  final PerfilService _service;

  Result<Perfil> perfil = Result.loading();

  Future<void> carregarPerfil() async {
    perfil = Result.loading();
    notifyListeners();
    try {
      final dados = await _service.meuPerfil();
      perfil = Result.success(dados);
    } catch (error) {
      perfil = Result.error('Não foi possível carregar o perfil.');
    }
    notifyListeners();
  }
}
