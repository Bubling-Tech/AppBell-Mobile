import 'package:dio/dio.dart';
import 'ApiClient.dart';

class UserService {
  final ApiClient apiClient = ApiClient();


  /// Verificar a existência do e-mail
  Future<bool> verificarEmail(String email) async {
    try {
      // Envia o e-mail como query parameter
      final response = await apiClient.post(
        "/users/validar-email",
        {},
        queryParameters: {"email": email},
        withAuth: false,
      );

      // Se o status for 200, significa que o e-mail não está cadastrado
      if (response.statusCode == 200) {
        return true; // E-mail não cadastrado
      } else {
        return false;
      }
    } catch (e) {
      // Se der erro de conflito (409), é porque o e-mail já está cadastrado
      if (e is DioException && e.response?.statusCode == 409) {
        return false;
      }
      throw Exception("Erro ao verificar e-mail: $e");
    }
  }

  /// Enviar código de confirmação para o e-mail
  Future<void> enviarCodigoConfirmacao(String email) async {
    print("enviando requisção Token...");
    try {
      // Ajuste aqui: usando queryParameters para enviar o e-mail
      final response = await apiClient.post(
        "/users/enviar-token-confirmacao",
        {},
        queryParameters: {"email": email},
        withAuth: false,
      );

      if (response.statusCode != 200) {
        throw Exception("Erro ao enviar código de confirmação.");
      }
    } catch (e) {
      throw Exception("Erro ao enviar código de confirmação: $e");
    }
  }


  /// Confirmar código de confirmação para cadastro
  Future<void> confirmarCodigoConfirmacao(String email, String token) async {
    try {
      final response = await apiClient.post(
        "/users/confirmar-token-confirmacao",
        {
          "email": email,
          "token": token,
        },
        withAuth: false,
      );

      if (response.statusCode != 200) {
        throw Exception("Erro ao confirmar código de confirmação.");
      }
    } catch (e) {
      throw Exception("Erro ao confirmar código de confirmação: $e");
    }
  }

  /// Enviar código de recuperação de senha para o e-mail
  Future<void> enviarCodigoRecuperacao(String email) async {
    try {
      final response = await apiClient.post(
        "/users/enviar-token-recuperacao",
        {"email": email},
        withAuth: false,
      );

      if (response.statusCode != 200) {
        throw Exception("Erro ao enviar código de recuperação.");
      }
    } catch (e) {
      throw Exception("Erro ao enviar código de recuperação: $e");
    }
  }

  /// Confirmar código de recuperação de senha
  Future<void> confirmarCodigoRecuperacao(String email, String token) async {
    try {
      final response = await apiClient.post(
        "/users/confirmar-token-recuperacao",
        {
          "email": email,
          "token": token,
        },
        withAuth: false,
      );

      if (response.statusCode != 200) {
        throw Exception("Erro ao confirmar código de recuperação.");
      }
    } catch (e) {
      throw Exception("Erro ao confirmar código de recuperação: $e");
    }
  }
}
