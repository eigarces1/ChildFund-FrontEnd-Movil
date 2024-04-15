import 'dart:convert';
import 'package:childfund_evaluation/utils/api_service.dart';
import 'package:childfund_evaluation/utils/models/child.dart';
import 'package:childfund_evaluation/utils/models/test_send.dart';
import 'package:childfund_evaluation/utils/models/test_send_ev1.dart';
import 'package:childfund_evaluation/utils/models/test_send_ev2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:childfund_evaluation/utils/models/evaluator.dart';
import 'package:childfund_evaluation/utils/models/parent.dart';

class Storage {
  /*
    * Funciones para token
  */
  Future<void> guardarToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> obtenerToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      return token;
    } else {
      return null;
    }
  }

  /*
    * Funciones para padres
  */
  Future<void> guardarPadre(Parent? pdGlobal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('padre', jsonEncode(pdGlobal!.toJson()));
  }

  Future<bool> existePadre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('padre');
    return (jsonString != null);
  }

  Future<Parent?> obtenerPadre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('padre');
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return Parent.fromJson(jsonMap);
    } else {
      return null;
    }
  }

  Future<void> guardarListadoHijos(Parent pdGlobal, String token) async {
    final childrenData =
        await ApiService.getChildrenByParentId(pdGlobal.parentId, token);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('childrenList', jsonEncode(childrenData));

    final aux = [];
    for (int i = 0; i < childrenData!.length; i++) {
      Child ch = await ApiService.getChildrenById(childrenData[i]['child_id']);
      aux.add(ch.toJson());
    }
    await prefs.setString('childInfoList', jsonEncode(aux));
  }

  Future<List<dynamic>?> obtenerChildrenList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('childrenList');
    if (jsonString != null) {
      List<dynamic>? jsonMap = jsonDecode((jsonString));
      return jsonMap;
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> obtenerInfoChildList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('childInfoList');
    if (jsonString != null) {
      List<dynamic>? jsonMap = jsonDecode((jsonString));
      List<dynamic>? toReturn = [];
      for (int i = 0; i < jsonMap!.length; i++) {
        toReturn.add(Child.fromJson(jsonMap[i]));
      }
      return toReturn;
    } else {
      return null;
    }
  }

  Future<void> guardarTestParent(List<dynamic> test) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('parentTest', jsonEncode(test));
  }

  //Funcion para evaluar si existen pruebas pendientes de los padres
  Future<bool> existenTest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('parentTest');
    return (jsonString == null);
  }

  Future<List<dynamic>?> obtenerTestParent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('parentTest');
    if (jsonString != null) {
      List<dynamic>? jsonMap = jsonDecode(jsonString);
      List<dynamic>? toReturn = [];
      for (int i = 0; i < jsonMap!.length; i++) {
        toReturn.add(TestToSend.fromJson(jsonMap[i]));
      }
      return toReturn;
    } else {
      return null;
    }
  }

  /*
    * Funciones para evaluadores
  */
  Future<void> guardarEv(Evaluator? evGlobal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('evaluador', jsonEncode(evGlobal!.toJson()));
  }

  Future<bool> existeEv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('evaluador');
    return (jsonString != null);
  }

  Future<Parent?> obtenerEv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('evaluador');
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return Parent.fromJson(jsonMap);
    } else {
      return null;
    }
  }

  Future<void> guardarAsignaciones(int id, String token) async {
    final childrenData = await ApiService.getAsignaciones(id, token);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('asignaciones', jsonEncode(childrenData));

    final aux = [];
    for (int i = 0; i < childrenData!.length; i++) {
      Child ch = await ApiService.getChildrenById(childrenData[i]['child_id']);
      aux.add(ch.toJson());
    }
    await prefs.setString('childInfoListEv', jsonEncode(aux));
  }

  Future<List<dynamic>?> obtenerAsignaciones() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('asignaciones');
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return jsonMap;
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> obtenerChildInfoEv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('childInfoListEv');
    if (jsonString != null) {
      List<dynamic>? jsonMap = jsonDecode((jsonString));
      List<dynamic>? toReturn = [];
      for (int i = 0; i < jsonMap!.length; i++) {
        toReturn.add(Child.fromJson(jsonMap[i]));
      }
      return toReturn;
    } else {
      return null;
    }
  }

  Future<void> guardarTest1Ev(List<dynamic> test) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('evTest1', jsonEncode(test));
  }

  Future<void> guardarTest2Ev(List<dynamic> test) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('evTest2', jsonEncode(test));
  }

  Future<List<dynamic>?> obtenerTest1Ev() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('evTest1');
    if (jsonString != null) {
      List<dynamic>? jsonMap = jsonDecode(jsonString);
      List<dynamic>? toReturn = [];
      for (int i = 0; i < jsonMap!.length; i++) {
        toReturn.add(TestEv1.fromJson(jsonMap[i]));
      }
      return toReturn;
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> obtenerTest2Ev() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('evTest2');
    if (jsonString != null) {
      List<dynamic>? jsonMap = jsonDecode(jsonString);
      List<dynamic>? toReturn = [];
      for (int i = 0; i < jsonMap!.length; i++) {
        toReturn.add(TestEnv2.fromJson(jsonMap[i]));
      }
      return toReturn;
    } else {
      return null;
    }
  }

  Future<bool> existeTest1Ev() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString1 = prefs.getString('evTest1');
    final jsonString2 = prefs.getString('evTest2');
    return (jsonString1 != null || jsonString2 != null);
    /**
     * * V -> existe
     * * F -> no existe
     */
  }

  /*
    * Funcion para eliminar cualquier elemento del local storage
  */
  Future<void> eliminarDataParent(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (key == "all") {
      await prefs.remove('token');
      await prefs.remove('padre');
      await prefs.remove('childrenList');
      await prefs.remove('childInfoList');
      await prefs.remove('parentTest');
    } else {
      await prefs.remove(key);
    }
  }

  Future<void> eliminarDataEv(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (key == "all") {
      await prefs.remove('token');
      await prefs.remove('evaluador');
      await prefs.remove('asignaciones');
      await prefs.remove('childInfoListEv');
      await prefs.remove('evTest1');
      await prefs.remove('evTest2');
    } else {
      await prefs.remove(key);
    }
  }
}
