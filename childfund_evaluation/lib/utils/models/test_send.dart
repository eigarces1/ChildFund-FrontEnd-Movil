class TestToSend {
  final int testId;
  final String jsonData;

  TestToSend({required this.testId, required this.jsonData});

  TestToSend.vacio()
      : testId = 0,
        jsonData = '';

// Método para convertir una instancia de TestToSend a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'testId': testId,
      'jsonData': jsonData,
    };
  }

  // Constructor para crear una instancia de TestToSend a partir de un mapa JSON
  factory TestToSend.fromJson(Map<String, dynamic> json) {
    return TestToSend(
      testId: json['testId'] ?? 0,
      jsonData: json['jsonData'] ?? '',
    );
  }

  @override
  String toString() {
    return 'TestToSend{testId: $testId, jsonData: $jsonData}';
  }
}
