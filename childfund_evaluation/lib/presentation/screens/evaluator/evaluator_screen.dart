import 'package:childfund_evaluation/presentation/screens/evaluator/asignaciones_screen.dart';
import 'package:childfund_evaluation/system/globals.dart';
import 'package:flutter/material.dart';

class EvaluatorPage extends StatelessWidget {
  const EvaluatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Evaluador'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Hola ' + evGlobal.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(evGlobal.rol),
                const Divider(),
                const SizedBox(height: 8.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AsignacionesPage()),
                      );
                    },
                    child: const Text('Mis asignaciones'))
              ],
            )));
  }
}
