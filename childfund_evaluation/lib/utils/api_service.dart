import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
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
  
}
