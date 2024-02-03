import 'package:flutter/material.dart';

class ChildEvaluationFormWidget extends StatelessWidget {
  final String indicator;
  final String level;
  final String motorName;
  final String posicion;
  final String materiales;
  final String instrucciones;
  final String respuesta;
  final String image;
  final bool? accomplished;
  final ValueChanged<bool?>?
      onChanged; // Callback function to notify parent widget

  const ChildEvaluationFormWidget({
    Key? key,
    required this.posicion,
    required this.image,
    required this.level,
    required this.materiales,
    required this.instrucciones,
    required this.respuesta,
    required this.motorName,
    required this.indicator,
    this.accomplished,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$motorName - $indicator - Nivel $level'),
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
          const SizedBox(height: 8.0),
          Image.asset(
            'assets/images/$image.jpg', // Replace this with the path to your image asset
            width: 200, // Adjust width as needed
            height: 200, // Adjust height as needed
            fit: BoxFit.contain, // Adjust the fit as needed
          ),
          const SizedBox(height: 16.0),
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
