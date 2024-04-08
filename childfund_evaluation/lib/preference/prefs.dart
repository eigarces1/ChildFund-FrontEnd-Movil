import 'package:shared_preferences/shared_preferences.dart';
import 'package:childfund_evaluation/utils/models/evaluator.dart';
import 'package:childfund_evaluation/utils/models/parent.dart';

class Storage {
  Future<void> guardarDatosUsuario(
      Evaluator? evGlobal, Parent? pdGlobal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (evGlobal != null) {
      await prefs.setString('usuario', evGlobal.getData());
    } else if (pdGlobal != null) {
      await prefs.setString('usuario', pdGlobal.getData());
    } else {}
  }

// Función para obtener los datos del usuario
  Future<String> obtenerDatosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usuario = prefs.getString('usuario') ?? '';
    return usuario;
  }

// Función para eliminar los datos del usuario
  Future<void> eliminarDatosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('usuario');
  }
}
