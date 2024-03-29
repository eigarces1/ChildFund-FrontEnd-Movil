import 'package:childfund_evaluation/presentation/screens/evaluator/child_details_screen.dart';
import 'package:childfund_evaluation/presentation/screens/login/sing_in.dart';
import 'package:childfund_evaluation/system/globals.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:childfund_evaluation/utils/models/child.dart';
import 'package:flutter/material.dart';
import '../../../utils/api_service.dart';

class AsignacionesPage extends StatefulWidget {
  const AsignacionesPage({Key? key}) : super(key: key);

  @override
  _AsignacionesPageState createState() => _AsignacionesPageState();
}

class _AsignacionesPageState extends State<AsignacionesPage> {
  List<Map<String, dynamic>>? children;

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    final childrenData =
        await ApiService.getAsignaciones(evGlobal.officerId, tokenGlobal);
    setState(() {
      children = childrenData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis asignaciones'),
        backgroundColor: AppColors.primaryColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // Limpia el token al cerrar la sesión
                tokenGlobal = '';
                // Navega a la pantalla de inicio de sesión
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SingIn()),
                  (route) => false,
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Cerrar sesión'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: children == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: children!.length,
              itemBuilder: (context, index) {
                final child = children![index];
                return ListTile(
                  title: Text(child['child_name']),
                  subtitle: Text(child['child_lastname']),
                  onTap: () {
                    _navigateToChildDetails(
                        child['child_id'], child['test_id']);
                  },
                  // Otros campos del hijo que desees mostrar
                );
              },
            ),
    );
  }

  void _navigateToChildDetails(int id, int testId) {
    Future<dynamic> childOne = _getChild(id);

    childOne.then((ch) {
      if (ch is Child) {
        Child children = ch;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChildDetailsPage(
              child: children,
              testid: testId,
            ), // Pasa el niño seleccionado a la página de detalles
          ),
        );
      } else {
        print('Niño no encontrado');
      }
    });
  }

  Future<dynamic> _getChild(int id) async {
    return ApiService.getChildrenById(id);
  }
}
