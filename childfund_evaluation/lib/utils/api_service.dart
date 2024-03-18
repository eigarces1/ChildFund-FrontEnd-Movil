import 'dart:convert';
import 'dart:js_interop';
import 'package:http/http.dart' as http;
import '../utils/models/evaluator.dart';
import '../utils/models/parent.dart';

class ApiService {
  static String token = '';

  static Future<String?> signIn(String email, String password) async {
    final url = Uri.parse('https://escalav2.app/api/user/signin');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mail': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        token = responseData['token'];
        return responseData['token'];
      } else {
        print('Error al iniciar sesión: ${responseData['message']}');
        return null;
      }
    } else {
      print('Error al iniciar sesión: ${response.statusCode}');
      return null;
    }
  }

  static Future<dynamic> getMe(String token) async {
    final url = Uri.parse('https://escalav2.app/api/user/me');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic>? userData = responseData['data'];
      if (userData != null) {
        final String role = userData['rol'];
        if (role == 'evaluator') {
          return Evaluator(
            userId: responseData['data']['user_id'],
            rol: responseData['data']['rol'],
            mail: responseData['data']['mail'],
            name: responseData['data']['name'],
            lastname: responseData['data']['lastname'],
            identificacion: responseData['data']['identification'],
            phone: responseData['data']['phone'],
            position: responseData['data']['position'] ??
                '', // Aquí se maneja el valor nulo
            officerId: responseData['data']['officer_id'],
          );
        } else if (role == 'parent') {
          return Parent(
            userId: responseData['data']['user_id'],
            rol: responseData['data']['rol'],
            mail: responseData['data']['mail'],
            name: responseData['data']['name'],
            lastname: responseData['data']['lastname'],
            identificacion: responseData['data']['identification'],
            phone: responseData['data']['phone'],
            position: responseData['data']['position'] ??
                '', // Aquí se maneja el valor nulo
          );
        }
      }
    } else {
      print("Error al conseguir el usuario");
      return null;
    }
  }

  static Future<dynamic> getAsignaciones(int id, String t) async {
    final url = Uri.parse(
        'https://escalav2.app/api/test/list_by_last_stage_and_officer_id?last_stage=ASSIGNED&officer_id=$id');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': t,
    });
    List<String>? data;
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic>? testData = responseData['data'];
      //print(testData?['tests']);
      return testData?['tests'];
    } else {
      print("Error al conseguir la informacion de los tests");
      return null;
    }
  }
}
