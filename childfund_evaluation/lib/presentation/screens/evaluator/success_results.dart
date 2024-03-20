import 'package:childfund_evaluation/presentation/screens/evaluator/asignaciones_screen.dart';
import 'package:flutter/material.dart';

class SuccessParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pantalla de Resultados'),
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
                    MaterialPageRoute(builder: (context) => AsignacionesPage()),
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
