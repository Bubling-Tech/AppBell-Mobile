import 'package:dio/dio.dart';
import 'ApiClient.dart';

class LocationService {
  final ApiClient apiClient = ApiClient();

  Future<List<Map<String, dynamic>>> fetchStates() async {
    try {
      Response response = await apiClient.get("/estados", withAuth: false);
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception("Erro ao buscar estados: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchCities(int stateId) async {
    try {
      Response response = await apiClient.get("/cidades/estado/$stateId", withAuth: false);
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception("Erro ao buscar cidades: $e");
    }
  }
}
