import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/models/evaluator.dart';

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

  static Future<Evaluator?> getMe(String token) async {
    final url = Uri.parse('https://escalav2.app/api/user/me');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        return Evaluator(
            userId: responseData['data']['user_id'],
            rol: responseData['data']['rol'],
            mail: responseData['data']['mail'],
            name: responseData['data']['name'],
            lastname: responseData['data']['lastname'],
            identificacion: responseData['data']['identification'],
            phone: responseData['data']['phone'],
            position: responseData['data']['position']);
        //return responseData['data'];
      } else {
        print("Error al conseguir el user");
        return null;
      }
    } else {
      print("Error al conseguir el user");
      return null;
    }
  }
}
