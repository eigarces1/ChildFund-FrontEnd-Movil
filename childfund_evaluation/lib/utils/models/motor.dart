import 'package:childfund_evaluation/utils/models/indicator.dart';

class Motor {
  final String motorName;
  final List<Indicator> indicators;

  const Motor({required this.motorName, required this.indicators});

  Map<String, dynamic> toJson() {
    return {
      'motor': motorName,
      'indicadores': indicators.map((indicador) => indicador.toJson()).toList(),
    };
  }
}
