import 'dart:convert';
import 'package:childfund_evaluation/utils/models/child.dart';
import 'package:childfund_evaluation/utils/models/evaluation.dart';
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
            parentId: responseData['data']['parent_id'],
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

  static Future<List<Map<String, dynamic>>?> getAsignaciones(
      int id, String t) async {
    final url = Uri.parse(
        'https://escalav2.app/api/test/list_by_last_stage_and_officer_id?last_stage=ASSIGNED&officer_id=$id');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': t,
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        // La clave 'data' contiene una lista de hijos
        List<dynamic> asignedData = responseData['data']['tests'];
        // Mapear los datos de los hijos en una lista de mapas
        List<Map<String, dynamic>> childrenList = asignedData
            .map((child) => Map<String, dynamic>.from(child))
            .toList();
        return childrenList;
      } else {
        print(
            'Error al obtener la lista de asignados: ${responseData['message']}');
        return null;
      }
    } else {
      print('Error al obtener la lista de asignados: ${response.statusCode}');
      return null;
    }
  }

  // Método para obtener la lista de hijos por el ID del padre
  static Future<List<Map<String, dynamic>>?> getChildrenByParentId(
      int parentId, String t) async {
    final url = Uri.parse(
        'https://escalav2.app/api/child/list_by_parent_id?parent_id=$parentId&limit=10&offset=0');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': t,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        // La clave 'data' contiene una lista de hijos
        List<dynamic> childrenData = responseData['data'];
        // Mapear los datos de los hijos en una lista de mapas
        List<Map<String, dynamic>> childrenList = childrenData
            .map((child) => Map<String, dynamic>.from(child))
            .toList();
        return childrenList;
      } else {
        print('Error al obtener la lista de hijos: ${responseData['message']}');
        return null;
      }
    } else {
      print('Error al obtener la lista de hijos: ${response.statusCode}');
      return null;
    }
  }

  static Future<dynamic> getChildrenById(int parentId) async {
    final url = Uri.parse(
        'https://escalav2.app/api/child/get_by_child_id?child_id=$parentId');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic>? childData = responseData['data'];
      if (childData != null) {
        return Child(
            childId: responseData['data']['child_id'],
            name: responseData['data']['name'],
            lastname: responseData['data']['lastname'],
            childNumber: responseData['data']['child_number'],
            gender: responseData['data']['gender'],
            birthdate: responseData['data']['birthdate'],
            community: responseData['data']['community'],
            communityType: responseData['data']['community_type'],
            village: responseData['data']['village'],
            status: responseData['data']['status'],
            updatedAt: responseData['data']['updated_at'],
            createdAt: responseData['data']['created_at']);
      }
    } else {
      print('Error al obtener la lista de hijos: ${response.statusCode}');
      return null;
    }
  }

  static Future<void> enviarEvaluacion(
      Evaluation evaluation, int testId) async {
    final url = Uri.parse(
        'https://escalav2.app/api/test_child_condition/create?test_id=$testId');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(<String, dynamic>{
          'person_in_charge': evaluation.personInCharge,
          'reading': evaluation.reading.toString(),
          'education': evaluation.education.toString(),
          'education_years': evaluation.educationYears,
          'initial_stimulation': evaluation.initialStimulation.toString(),
          'program_place': evaluation.programPlace,
          'childfund_partner': evaluation.childfundPartner,
          'nongovernmental': evaluation.nongovernmental,
          'governmental': evaluation.governmental,
          'CIBV': evaluation.CIBV.toString(),
          'CNH': evaluation.CNH.toString(),
          'initial_education': evaluation.initialEducation.toString(),
          'other_sponsor': evaluation.otherSponsor,
          'disability': evaluation.disability,
          'health_condition': evaluation.healthCondition,
          'health_condition_description': evaluation.healthConditionDescription,
          'height': evaluation.height.toString(),
          'weight': evaluation.weight.toString(),
          'observations': evaluation.observations,
        }));
    if (response.statusCode == 200) {
      print('Solicitud POST enviada con éxito');
    } else {
      print('Error al enviar la solicitud POST: ${response.body}');
    }
  }

  static Future<void> submitResults(String json, int id, int value) async {
    final url =
        Uri.parse('https://escalav2.app/api/test/save_responses?test_id=$id');
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(<String, dynamic>{
          'responses': json,
          "development_ratio": value,
        }));
    if (response.statusCode == 200) {
      print('Solicitud POST enviada con éxito');
    } else {
      print('Error al enviar la solicitud PUT: ${response.body}');
    }
  }

  static Future<void> submitResultsParents(String json, int id) async {
    final url = Uri.parse(
        'https://escalav2.app/api/child_family_activity/save_responses?child_id=$id');
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(<String, dynamic>{'responses': json}));
    if (response.statusCode == 200) {
      print('Solicitud POST enviada con éxito');
    } else {
      print('Error al enviar la solicitud PUT: ${response.body}');
    }
  }
}
