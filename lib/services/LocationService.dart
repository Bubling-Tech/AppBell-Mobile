import 'ApiClient.dart';

class LocationService {
  final ApiClient apiClient = ApiClient();

  Future<List<Map<String, dynamic>>> fetchStates() async {
    final response = await apiClient.get("/estados", withAuth: false);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data);
    }

    throw Exception(response.message ?? "Erro ao buscar estados mockados.");
  }

  Future<List<Map<String, dynamic>>> fetchCities(int stateId) async {
    final response = await apiClient.get("/cidades/estado/$stateId", withAuth: false);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data);
    }

    throw Exception(response.message ?? "Erro ao buscar cidades mockadas.");
  }
}
