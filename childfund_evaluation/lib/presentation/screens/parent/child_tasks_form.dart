import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:childfund_evaluation/preference/prefs.dart';
import 'package:childfund_evaluation/utils/api_service.dart';
import 'package:childfund_evaluation/utils/controllers/net_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ChildEvaluationFormWidget extends StatelessWidget {
  final String position;
  final String image;
  final String materiales;
  final String instrucciones;
  final String indicator;
  final bool? accomplished;
  final ValueChanged<bool?>? onChanged;

  const ChildEvaluationFormWidget({
    Key? key,
    required this.position,
    required this.image,
    required this.materiales,
    required this.instrucciones,
    required this.indicator,
    this.accomplished,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late StreamSubscription subscription;
    late StreamSubscription internetSubscription;
    bool hasInternet = false;
    NetController netController = NetController();

    Storage stg = new Storage();

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

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Tarea $indicator',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Posición:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(position),
          SizedBox(height: 8.0),
          Text(
            'Materiales:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(materiales),
          SizedBox(height: 8.0),
          Text(
            'Instrucciones:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(instrucciones),
          SizedBox(height: 8.0),
          Image.asset(
            'assets/images_family_tasks/$image.jpg',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.check,
                    color: accomplished == true ? Colors.green : Colors.grey),
                onPressed: () {
                  onChanged?.call(true);
                },
              ),
              IconButton(
                icon: Icon(Icons.close,
                    color: accomplished == false ? Colors.red : Colors.grey),
                onPressed: () {
                  onChanged?.call(false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
