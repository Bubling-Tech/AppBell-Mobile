import 'package:flutter/foundation.dart';

import 'ApiClient.dart';

class UserService {
  final ApiClient apiClient = ApiClient();

  /// Verificar a existência do e-mail
  Future<bool> verificarEmail(String email) async {
    debugPrint('🔍 Verificando disponibilidade do e-mail: $email');
    final response = await apiClient.post(
      "/users/validar-email",
      {},
      queryParameters: {"email": email},
      withAuth: false,
    );

    if (response.statusCode == 200) {
      debugPrint('✅ E-mail disponível.');
      return true;
    }

    if (response.statusCode == 409) {
      debugPrint('⚠️  E-mail já cadastrado.');
      return false;
    }

    throw Exception(response.message ?? "Erro ao verificar e-mail.");
  }

  /// Enviar código de confirmação para o e-mail
  Future<void> enviarCodigoConfirmacao(String email) async {
    debugPrint('📨 Enviando token de confirmação para $email');
    final response = await apiClient.post(
      "/users/enviar-token-confirmacao",
      {},
      queryParameters: {"email": email},
      withAuth: false,
    );

    if (response.statusCode != 200) {
      throw Exception(response.message ?? "Erro ao enviar código de confirmação.");
    }
  }

  /// Confirmar código de confirmação para cadastro
  Future<void> confirmarCodigoConfirmacao(String email, String token) async {
    debugPrint('🔐 Confirmando token de cadastro para $email');
    final response = await apiClient.post(
      "/users/confirmar-token-confirmacao",
      {
        "email": email,
        "token": token,
      },
      withAuth: false,
    );

    if (response.statusCode != 200) {
      throw Exception(response.message ?? "Erro ao confirmar código de confirmação.");
    }
  }

  /// Enviar código de recuperação de senha para o e-mail
  Future<void> enviarCodigoRecuperacao(String email) async {
    debugPrint('♻️  Enviando token de recuperação para $email');
    final response = await apiClient.post(
      "/users/enviar-token-recuperacao",
      {"email": email},
      withAuth: false,
    );

    if (response.statusCode != 200) {
      throw Exception(response.message ?? "Erro ao enviar código de recuperação.");
    }
  }

  /// Confirmar código de recuperação de senha
  Future<void> confirmarCodigoRecuperacao(String email, String token) async {
    debugPrint('🔁 Confirmando token de recuperação para $email');
    final response = await apiClient.post(
      "/users/confirmar-token-recuperacao",
      {
        "email": email,
        "token": token,
      },
      withAuth: false,
    );

    if (response.statusCode != 200) {
      throw Exception(response.message ?? "Erro ao confirmar código de recuperação.");
    }
  }
}
