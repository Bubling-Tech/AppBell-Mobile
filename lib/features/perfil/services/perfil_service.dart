import 'package:to_com_bell_app/core/mock/mock_data.dart';
import 'package:to_com_bell_app/features/perfil/models/perfil.dart';

class PerfilService {
  Future<Perfil> meuPerfil() async {
    await Future.delayed(const Duration(milliseconds: 220));
    return mockPerfil;
  }
}
