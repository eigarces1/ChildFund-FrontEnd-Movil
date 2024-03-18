import 'package:flutter/material.dart';
import 'package:childfund_evaluation/presentation/screens/evaluator/evaluation_data.dart';
import '../../../utils/models/child.dart';

class ChildDetailsPage extends StatelessWidget {
  final Child child;

  const ChildDetailsPage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Niño'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${child.name} ${child.lastname}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Género: ${child.gender}'),
            Text('Fecha de Nacimiento: ${child.birthdate}'),
            Text('Comunidad: ${child.community}'),
            Text('Tipo de Comunidad: ${child.communityType}'),
            Text('Número de Niño: ${child.childNumber}'),
            Text('Número de Niño: ${child.childNumber}'),
            const Divider(),
            const SizedBox(height: 8.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EvaluationScreen(), // Pasa el niño seleccionado a la página de detalles
                    ),
                  );
                },
                child: Text('Continuar'),
              ),
            )
            // Agrega más detalles según sea necesario
          ],
        ),
      ),
    );
  }
}
