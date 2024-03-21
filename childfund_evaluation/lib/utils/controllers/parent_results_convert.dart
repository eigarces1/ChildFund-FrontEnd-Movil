import 'dart:convert';

import 'package:childfund_evaluation/utils/models/indicator_with_level.dart';
import 'package:childfund_evaluation/utils/models/task_with_level.dart';

class ParentConverter {
  final Map<String, List<TaskWithLevel>> motorsDict;

  ParentConverter({required this.motorsDict});

  String convertToJson() {
    Map<String, dynamic> data = {}; //JsonDATA
    Iterable<MapEntry<String, List<TaskWithLevel>>> entradas =
        motorsDict.entries;
    /*
      * Conversion a json    
    */
    List<Map<String, dynamic>> list = [];
    for (var motor in entradas) {
      data['level'] = motor.value[0].level;
      for (var item in motor.value) {
        list.add(item.indicator.toJson());
      }
      //print(list);
    }
    data['tareas'] = list;
    String jsonRequest = jsonEncode(data);
    return jsonRequest;
  }
}
