import 'dart:convert';
import 'package:dio/dio.dart';

class ApiClient {
  late Dio dio;
  static const String baseUrl = "http://10.0.2.2:8081";

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    // 🔹 Adicionando Interceptor para Token JWT automaticamente
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await getToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          await removeToken();
        }
        return handler.reject(e);
      },
    ));
  }


  Future<Response> get(String endpoint, {bool withAuth = true}) async {
    if (!withAuth) {
      return Dio().get("$baseUrl$endpoint");
    }
    return dio.get(endpoint);
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data, {Map<String, dynamic>? queryParameters, bool withAuth = true}) async {
    if (!withAuth) {
      return Dio().post("$baseUrl$endpoint", data: data, queryParameters: queryParameters);
    }
    return dio.post(endpoint, data: data);
  }



  static Future<String?> getToken() async {
    return "SEU_TOKEN";
  }

  static Future<void> removeToken() async {

  }
}
