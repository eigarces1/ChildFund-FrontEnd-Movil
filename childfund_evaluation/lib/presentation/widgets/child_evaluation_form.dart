import 'package:flutter/material.dart';

class ChildEvaluationFormWidget extends StatelessWidget {
  final String posicion;
  final String materiales;
  final String instrucciones;
  final String respuesta;

  const ChildEvaluationFormWidget({
    required this.posicion,
    required this.materiales,
    required this.instrucciones,
    required this.respuesta,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Posición:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(posicion),
          const SizedBox(height: 8.0),
          
          const Text(
            'Materiales:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(materiales),
          const SizedBox(height: 8.0),

          const Text(
            'Instrucciones:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(instrucciones),
          const SizedBox(height: 8.0),

          const Text(
            'Respuesta:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(respuesta),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
