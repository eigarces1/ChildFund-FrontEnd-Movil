import 'dart:convert';

import 'package:childfund_evaluation/utils/models/indicator_with_level.dart';

class EvaluatorConverter {
  final Map<String, List<IndicatorWithLevel>> motorsDict;

  EvaluatorConverter({required this.motorsDict});

  String convertToJson() {
    List<Map<String, dynamic>> jsonData = []; //JsonDATA
    Iterable<MapEntry<String, List<IndicatorWithLevel>>> entradas =
        motorsDict.entries;
    /*
      * Conversion a json    
    */
    for (var motor in entradas) {
      Map<String, dynamic> data = {};
      data['motor'] = motor.key;
      List<Map<String, dynamic>> list = [];
      for (var item in motor.value) {
        list.add(item.indicator.toJson());
      }
      data['indicadores'] = list;
      //print("=============================================");
      jsonData.add(data);
    }
    String jsonRequest = jsonEncode(jsonData);
    return jsonRequest;
  }
}
