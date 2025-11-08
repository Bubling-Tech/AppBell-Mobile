class LocationService {
  static const List<Map<String, dynamic>> _mockStates = [
    {"id": 29, "nome": "Bahia"},
    {"id": 35, "nome": "São Paulo"},
    {"id": 33, "nome": "Rio de Janeiro"},
    {"id": 26, "nome": "Pernambuco"},
    {"id": 23, "nome": "Ceará"},
  ];

  static const Map<int, List<Map<String, dynamic>>> _mockCities = {
    29: [
      {"id": 2905701, "nome": "Salvador"},
      {"id": 2927408, "nome": "Porto Seguro"},
      {"id": 2910800, "nome": "Feira de Santana"},
    ],
    35: [
      {"id": 3550308, "nome": "São Paulo"},
      {"id": 3549805, "nome": "Santos"},
      {"id": 3509502, "nome": "Campinas"},
    ],
    33: [
      {"id": 3304557, "nome": "Rio de Janeiro"},
      {"id": 3304904, "nome": "Niterói"},
      {"id": 3301705, "nome": "Cabo Frio"},
    ],
    26: [
      {"id": 2611606, "nome": "Recife"},
      {"id": 2607901, "nome": "Olinda"},
      {"id": 2610707, "nome": "Petrolina"},
    ],
    23: [
      {"id": 2304400, "nome": "Fortaleza"},
      {"id": 2312909, "nome": "Sobral"},
      {"id": 2310804, "nome": "Juazeiro do Norte"},
    ],
  };

  Future<List<Map<String, dynamic>>> fetchStates() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockStates.map((state) => Map<String, dynamic>.from(state)).toList();
  }

  Future<List<Map<String, dynamic>>> fetchCities(int stateId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final cities = _mockCities[stateId] ?? const [];
    return cities.map((city) => Map<String, dynamic>.from(city)).toList();
  }
}
