import 'dart:async';

import 'package:childfund_evaluation/preference/prefs.dart';
import 'package:childfund_evaluation/presentation/screens/login/sing_in.dart';
import 'package:childfund_evaluation/presentation/screens/parent/evaluation_parent_screen.dart';
import 'package:childfund_evaluation/system/globals.dart';
import 'package:childfund_evaluation/utils/api_service.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:childfund_evaluation/utils/controllers/net_controller.dart';
import 'package:flutter/material.dart';
import '../../../utils/models/child.dart';
import '../../../utils/controllers/age_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ChildDetailsPage extends StatefulWidget {
  final Child child;
  //final int testId;

  const ChildDetailsPage({Key? key, required this.child}) : super(key: key);

  @override
  _ChildDetailsPageState createState() => _ChildDetailsPageState();
}

class _ChildDetailsPageState extends State<ChildDetailsPage> {
  AgeController controller = AgeController();
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  bool hasInternet = false;
  NetController netController = new NetController();
  Storage stg = Storage();

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen(_showState);
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
    });
  }

  bool _showState(ConnectivityResult result) {
    final hasInternet = this.netController.isConected(result);
    print('Is Conected? : ${hasInternet}');
    bool existTest = false;
    stg.existenTest().then((value) {
      if (value) {
        stg.obtenerTestParent().then((t) {
          for (int i = 0; i < t!.length; i++) {
            ApiService.submitResultsParents(t[i]['jsonData'], t[i]['testId']);
          }
        });
      } else {
        print('No hay tests por guardad');
      }
    });
    return hasInternet;
  }

  final Map<String, int> ageLevelMap = {
    '0 a 3 meses': 1,
    '3.1 a 6 meses': 2,
    '6.1 a 9 meses': 3,
    '9.1 a 12 meses': 4,
    '12.1 a 16 meses': 5,
    '16.1 a 20 meses': 6,
    '20.1 a 24 meses': 7,
    '24.1 a 36 meses': 8,
    '36.1 a 48 meses': 9,
    '48.1 a 60 meses': 10,
    '60.1 a 72 meses': 11,
  };

  final Map<int, String> ageLevelMapReversed = {
    1: '0 a 3 meses',
    2: '3.1 a 6 meses',
    3: '6.1 a 9 meses',
    4: '9.1 a 12 meses',
    5: '12.1 a 16 meses',
    6: '16.1 a 20 meses',
    7: '20.1 a 24 meses',
    8: '24.1 a 36 meses',
    9: '36.1 a 48 meses',
    10: '48.1 a 60 meses',
    11: '60.1 a 72 meses',
  };

  void _continue() {
    List<int> data = controller.calculate(widget.child.birthdate);
    int level = data[0];
    int diff = data[1];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EvaluationParentScreen(
                  selectedAge: ageLevelMapReversed[level]!,
                  selectedLevel: level,
                  childAgeMonths: '$diff',
                  testId: widget.child.childId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información del infante'),
        backgroundColor: AppColors.primaryColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // Limpia el token al cerrar la sesión
                tokenGlobal = '';
                stg.eliminarDataParent('all');
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${widget.child.name} ${widget.child.lastname}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Número de Niño: ${widget.child.childNumber}'),
            Text('Género: ${widget.child.gender}'),
            Text('Fecha de Nacimiento: ${widget.child.birthdate}'),
            Text('Comunidad: ${widget.child.community}'),
            Text('Tipo de Comunidad: ${widget.child.communityType}'),
            Text('Pueblo: ${widget.child.village}'),
            Text('Fecha de actualización: ${widget.child.updatedAt}'),
            Text('Fecha de creación: ${widget.child.createdAt}'),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: _continue,
                child: const Text('Actividades para la familia'))
          ],
        ),
      ),
    );
  }
}
