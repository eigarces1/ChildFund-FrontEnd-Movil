import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:childfund_evaluation/preference/prefs.dart';
import 'package:childfund_evaluation/presentation/screens/login/sing_in.dart';
import 'package:childfund_evaluation/presentation/screens/parent/parent_screen.dart';
import 'package:childfund_evaluation/system/globals.dart';
import 'package:childfund_evaluation/utils/api_service.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:childfund_evaluation/utils/controllers/net_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class SuccessParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Storage stg = Storage();
    int tam = 0;
    late StreamSubscription subscription;
    late StreamSubscription internetSubscription;
    bool hasInternet = false;
    NetController netController = NetController();

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Resultados'),
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading:
              false, // Esta línea evita que aparezca la flecha de retroceso
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Los resultados han sido enviados con éxito',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ParentPage()),
                  );
                },
                child: Text('Finalizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
