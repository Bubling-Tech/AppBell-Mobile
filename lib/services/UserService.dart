import 'package:dio/dio.dart';
import 'ApiClient.dart';

class UserService {
  final ApiClient apiClient = ApiClient();

  Future<bool> verificarEmail(String email) async {
    try {
      final response = await apiClient.post(
        "/users/validar-email",
        {},
        queryParameters: {"email": email},
        withAuth: false,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 409) {
        return false;
      }
      throw Exception("Erro ao verificar e-mail: $e");
    }
  }

  Future<void> enviarCodigoConfirmacao(String email) async {
    try {
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
