import 'package:childfund_evaluation/utils/models/evaluation.dart';

class TestEv1 {
  final int testId;
  final Evaluation ev;

  TestEv1({required this.testId, required this.ev});

  // Método para convertir una instancia de TestEv1 a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'testId': testId,
      'ev': ev.toJson(), // Convertir Evaluation a JSON
    };
  }

  // Constructor para crear una instancia de TestEv1 a partir de un mapa JSON
  factory TestEv1.fromJson(Map<String, dynamic> json) {
    return TestEv1(
      testId: json['testId'] ?? 0,
      ev: Evaluation.fromJson(
          json['ev']), // Crear instancia de Evaluation desde JSON
    );
  }
}
