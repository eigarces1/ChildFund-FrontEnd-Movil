import 'dart:convert';

import 'package:childfund_evaluation/utils/api_service.dart';
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
    ApiService service;
    final childrenData =
        await ApiService.getChildrenByParentId(pdGlobal.parentId, token);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('childrenList', jsonEncode(childrenData));
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

  /*
    * Funciones para evaluadores
  */
  Future<void> guardarEv(Evaluator? evGlobal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('padre', jsonEncode(evGlobal!.toJson()));
  }

  Future<Parent?> obtenerEv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('padre');
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return Parent.fromJson(jsonMap);
    } else {
      return null;
    }
  }

  /*
    * Funcion para eliminar cualquier elemento del local storage
  */
  Future<void> eliminar(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
