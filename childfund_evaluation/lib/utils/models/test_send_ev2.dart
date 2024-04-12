class TestEnv2 {
  final String jsonData;
  final int testId;
  final int coeff;

  TestEnv2({required this.jsonData, required this.testId, required this.coeff});

  // Método para convertir una instancia de TestEnv2 a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'jsonData': jsonData,
      'testId': testId,
      'coeff': coeff,
    };
  }

  // Constructor para crear una instancia de TestEnv2 a partir de un mapa JSON
  factory TestEnv2.fromJson(Map<String, dynamic> json) {
    return TestEnv2(
      jsonData: json['jsonData'] ?? '',
      testId: json['testId'] ?? 0,
      coeff: json['coeff'] ?? 0,
    );
  }
}
