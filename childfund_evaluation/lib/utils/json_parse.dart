import 'dart:convert';
import 'package:childfund_evaluation/utils/models/age_group.dart';
import 'package:childfund_evaluation/utils/models/indicator.dart';
import 'package:childfund_evaluation/utils/models/motor.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<List<AgeGroup>> loadIndicatorsJsonData() async {
  try {
    String jsonString =
        await rootBundle.loadString('assets/data/indicadores.json');

    Map<String, dynamic> data = jsonDecode(jsonString);

    List<AgeGroup> ageGroups = [];

    // Extracting age groups
    List<dynamic> ageGroupDataList = data["edades"];
    for (var ageGroupData in ageGroupDataList) {
      List<Motor> motors = [];
      // Extracting motors for each age group
      List<dynamic> motorDataList = ageGroupData["motores"];
      for (var motorData in motorDataList) {
        List<Indicator> indicators = [];
        // Extracting indicators for each motor
        List<dynamic> indicatorDataList = motorData["indicadores"];
        for (var indicatorData in indicatorDataList) {
          Indicator indicator = Indicator(
              indicator: indicatorData["indicador"],
              materials: indicatorData["materiales"],
              instructions: indicatorData["instrucciones"],
              response: indicatorData["respuesta"],
              image: indicatorData["imagen"],
              position: indicatorData["posicion"]);
          indicators.add(indicator);
        }
        Motor motor = Motor(
          motorName: motorData["motor"],
          indicators: indicators,
        );
        motors.add(motor);
      }
      AgeGroup ageGroup = AgeGroup(
        level: int.parse(ageGroupData["level"]),
        range: ageGroupData["edad"],
        motors: motors,
      );
      ageGroups.add(ageGroup);
    }

    return ageGroups;
  } catch (e) {
    print('Error loading JSON data: $e');
    return []; // Or handle the error appropriately
  }
}
