import 'dart:math';

import 'package:flutter/foundation.dart';

class ApiResponse<T> {
  final T data;
  final int statusCode;
  final String? message;

  ApiResponse({required this.data, required this.statusCode, this.message});
}

class ApiClient {
  static const Duration _defaultDelay = Duration(milliseconds: 400);
  static const String baseUrl = "http://demo.appbell.mock";

  static const List<Map<String, dynamic>> _states = [
    {'id': 1, 'nome': 'São Paulo', 'sigla': 'SP'},
    {'id': 2, 'nome': 'Rio de Janeiro', 'sigla': 'RJ'},
    {'id': 3, 'nome': 'Minas Gerais', 'sigla': 'MG'},
  ];

  static final Map<int, List<Map<String, dynamic>>> _citiesByState = {
    1: [
      {'id': 101, 'nome': 'São Paulo'},
      {'id': 102, 'nome': 'Campinas'},
      {'id': 103, 'nome': 'Santos'},
    ],
    2: [
      {'id': 201, 'nome': 'Rio de Janeiro'},
      {'id': 202, 'nome': 'Niterói'},
      {'id': 203, 'nome': 'Petrópolis'},
    ],
    3: [
      {'id': 301, 'nome': 'Belo Horizonte'},
      {'id': 302, 'nome': 'Uberlândia'},
      {'id': 303, 'nome': 'Juiz de Fora'},
    ],
  };

  static final Set<String> _registeredEmails = {
    'contato@appbell.com',
    'demo@cliente.com',
  };

  static final Map<String, String> _confirmationTokens = {};
  static final Map<String, String> _recoveryTokens = {};

  Future<ApiResponse<dynamic>> get(String endpoint, {bool withAuth = true}) async {
    await Future.delayed(_defaultDelay);

    if (endpoint == '/estados') {
      debugPrint('📡 [MockApi] GET ' + endpoint);
      return ApiResponse<List<Map<String, dynamic>>>(
        data: List<Map<String, dynamic>>.from(_states),
        statusCode: 200,
        message: 'Estados mockados carregados com sucesso.',
      );
    }

    final cityMatch = RegExp(r'^/cidades/estado/(\d+)$').firstMatch(endpoint);
    if (cityMatch != null) {
      final stateId = int.parse(cityMatch.group(1)!);
      debugPrint('📡 [MockApi] GET ' + endpoint);
      return ApiResponse<List<Map<String, dynamic>>>(
        data: List<Map<String, dynamic>>.from(_citiesByState[stateId] ?? []),
        statusCode: 200,
        message: 'Cidades mockadas carregadas com sucesso.',
      );
    }

    return ApiResponse<String>(
      data: 'Endpoint não suportado: ' + endpoint,
      statusCode: 404,
      message: 'Endpoint não suportado: ' + endpoint,
    );
  }

  Future<ApiResponse<dynamic>> post(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, dynamic>? queryParameters,
    bool withAuth = true,
  }) async {
    await Future.delayed(_defaultDelay);
    debugPrint('📡 [MockApi] POST ' + endpoint);

    final rawEmail = (queryParameters != null && queryParameters.containsKey('email'))
        ? queryParameters['email']
        : data['email'];
    final email = rawEmail is String ? rawEmail.trim().toLowerCase() : null;

    switch (endpoint) {
      case '/users/validar-email':
        if (email == null || email.isEmpty) {
          return ApiResponse<Map<String, dynamic>>(
            data: {'available': false},
            statusCode: 400,
            message: 'E-mail inválido.',
          );
        }

        final available = !_registeredEmails.contains(email);
        return ApiResponse<Map<String, dynamic>>(
          data: {'available': available},
          statusCode: available ? 200 : 409,
          message: available
              ? 'E-mail disponível para cadastro.'
              : 'E-mail já cadastrado.',
        );

      case '/users/enviar-token-confirmacao':
        if (email == null || email.isEmpty) {
          return ApiResponse<Map<String, dynamic>>(
            data: {'sent': false},
            statusCode: 400,
            message: 'E-mail inválido para envio do token.',
          );
        }

        final token = _generateToken();
        _confirmationTokens[email] = token;
        debugPrint('🔐 Token de confirmação gerado: ' + token + ' para ' + email);
        return ApiResponse<Map<String, dynamic>>(
          data: {'sent': true, 'token': token},
          statusCode: 200,
          message: 'Token de confirmação enviado.',
        );

      case '/users/confirmar-token-confirmacao':
        final providedToken = data['token']?.toString();
        final storedToken = email != null ? _confirmationTokens[email] : null;
        final success = storedToken != null && storedToken == providedToken;

        return ApiResponse<Map<String, dynamic>>(
          data: {'success': success},
          statusCode: success ? 200 : 400,
          message: success ? 'Token confirmado com sucesso.' : 'Token inválido.',
        );

      case '/users/enviar-token-recuperacao':
        if (email == null || email.isEmpty) {
          return ApiResponse<Map<String, dynamic>>(
            data: {'sent': false},
            statusCode: 400,
            message: 'E-mail inválido para recuperação.',
          );
        }

        final token = _generateToken();
        _recoveryTokens[email] = token;
        debugPrint('♻️  Token de recuperação gerado: ' + token + ' para ' + email);
        return ApiResponse<Map<String, dynamic>>(
          data: {'sent': true, 'token': token},
          statusCode: 200,
          message: 'Token de recuperação enviado.',
        );

      case '/users/confirmar-token-recuperacao':
        final providedToken = data['token']?.toString();
        final storedToken = email != null ? _recoveryTokens[email] : null;
        final success = storedToken != null && storedToken == providedToken;

        return ApiResponse<Map<String, dynamic>>(
          data: {'success': success},
          statusCode: success ? 200 : 400,
          message: success ? 'Token de recuperação confirmado.' : 'Token inválido.',
        );
    }

    return ApiResponse<String>(
      data: 'Endpoint não suportado: ' + endpoint,
      statusCode: 404,
      message: 'Endpoint não suportado: ' + endpoint,
    );
  }

  static Future<String?> getToken() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return "TOKEN_DEMO";
  }

  static Future<void> removeToken() async {
    await Future.delayed(const Duration(milliseconds: 150));
    debugPrint('🧹 Token removido do mock.');
  }

  static String _generateToken() {
    final random = Random();
    return List.generate(6, (_) => random.nextInt(10).toString()).join();
  }
}
