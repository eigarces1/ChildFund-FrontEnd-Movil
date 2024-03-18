import 'dart:convert';
import 'package:childfund_evaluation/utils/models/age_group.dart';
import 'package:childfund_evaluation/utils/models/age_group_parent.dart';
import 'package:childfund_evaluation/utils/models/indicator.dart';
import 'package:childfund_evaluation/utils/models/motor.dart';
import 'package:childfund_evaluation/utils/models/tarea.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<List<List<int>>> loadCoeficientTable() async {
  try {
    String jsonString =
        await rootBundle.loadString('assets/data/coeficients.json');
    Map<String, dynamic> data = jsonDecode(jsonString);

    List<dynamic> dynamicList = data["coeficients"] ?? [];
    List<List<int>> listOfLists = [];

    // Iterate over the dynamic list and cast each element to int
    for (var dynamicInnerList in dynamicList) {
      if (dynamicInnerList is List) {
        List<int> innerList = [];
        for (var value in dynamicInnerList) {
          if (value is int) {
            innerList.add(value);
          } else {
            // Handle if the value is not an integer (e.g., ignore or handle accordingly)
          }
        }
        listOfLists.add(innerList);
      }
    }

    return listOfLists;
  } catch (e) {
    print('Error loading JSON data: $e');
    return [];
  }
}

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

Future<List<AgeGroupParent>> loadTasksJsonData() async {
  try {
    String jsonString =
        await rootBundle.loadString('assets/data/tareas_familia.json');

    Map<String, dynamic> data = jsonDecode(jsonString);

    List<AgeGroupParent> ageGroups = [];

    // Extracting age groups
    List<dynamic> ageGroupDataList = data["edades"];
    for (var ageGroupData in ageGroupDataList) {
      List<Tarea> tareas = [];
      // Extracting motors for each age group
      List<dynamic> motorDataList = ageGroupData["tareas"];
      for (var motorData in motorDataList) {
        Tarea tarea = Tarea(
            indicador: motorData['indicador'],
            materiales: motorData['materiales'],
            instrucciones: motorData['instrucciones'],
            imagen: motorData['imagen']);
        tareas.add(tarea);
      }
      AgeGroupParent ageGroup = AgeGroupParent(
        level: int.parse(ageGroupData['level']),
        range: ageGroupData['edad'],
        tareas: tareas,
      );
      ageGroups.add(ageGroup);
    }

    return ageGroups;
  } catch (e) {
    print('Error loading JSON data: $e');
    return []; // Or handle the error appropriately
  }
}
