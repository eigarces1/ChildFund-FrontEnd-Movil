import 'dart:async';
import 'dart:convert';
import 'package:childfund_evaluation/utils/api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:childfund_evaluation/presentation/screens/login/sing_in.dart';
import 'package:childfund_evaluation/presentation/screens/parent/children_list_screen.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:childfund_evaluation/utils/controllers/net_controller.dart';
import 'package:childfund_evaluation/utils/models/parent.dart';
import 'package:flutter/material.dart';
import 'package:childfund_evaluation/system/globals.dart';
import 'package:childfund_evaluation/preference/prefs.dart';

class ParentPage extends StatelessWidget {
  const ParentPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    late StreamSubscription subscription;
    late StreamSubscription internetSubscription;
    bool hasInternet = false;
    NetController netController = NetController();

    Storage stg = new Storage();
    Parent? padre;
    stg.obtenerPadre().then((Parent? p) {
      padre = p;
    });

    bool _showState(ConnectivityResult result) {
      final hasInternet = netController.isConected(result);
      print('Is Conected? : ${hasInternet}');
      bool existTest = false;
      stg.existenTest().then((value) {
        if (value) {
          //Si existen pruebas pendientes
          stg.obtenerTestParent().then((t) {
            for (int j = 0; j < t!.length; j++) {
              ApiService.submitResultsParents(t[j]['jsonData'], t[j]['testId']);
            }
          });
        } else {
          print('No hay tests por guardad');
        }
      });
      return hasInternet;
    }

    subscription = Connectivity().onConnectivityChanged.listen(_showState);
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet_ = status == InternetConnectionStatus.connected;
      hasInternet = hasInternet_;
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('Padre'),
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading:
              false, // Esta línea evita que aparezca la flecha de retroceso
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Bienvenido',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(paGlobal.rol),
                const Divider(),
                const SizedBox(height: 8.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChildrenListPage()),
                      );
                    },
                    child: const Text('Mis hijos'))
              ],
            )));
  }
}
