import 'package:flutter/material.dart';

class ParentEvaluationFormWidget extends StatelessWidget {
  final String indicator;
  final String level;
  final String materiales;
  final String instrucciones;
  final String image;
  final bool? accomplished;
  final Map<String, String> imagesRoute;
  final ValueChanged<bool?>?
      onChanged; // Callback function to notify parent widget

  const ParentEvaluationFormWidget({
    Key? key,
    required this.image,
    required this.level,
    required this.materiales,
    required this.instrucciones,
    required this.indicator,
    this.accomplished,
    this.onChanged,
    required this.imagesRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Tarea $indicator - Nivel $level',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    18, // Ajusta el tamaño del texto según tus necesidades
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          const SizedBox(height: 8.0),
          if (materiales != "")
            const Text(
              'Materiales:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          if (materiales != "") Text(materiales),
          const SizedBox(height: 8.0),
          const Text(
            'Instrucciones:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(instrucciones),
          const SizedBox(height: 8.0),
          const SizedBox(height: 8.0),
          Center(
              child: Container(
            child: Image.asset(
              'assets/images_family_tasks/${imagesRoute[level]}/$image.png', // Replace this with the path to your image asset
              width: 200, // Adjust width as needed
              height: 200, // Adjust height as needed
              fit: BoxFit.contain, // Adjust the fit as needed
            ),
          )),
          const SizedBox(height: 10.0),
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
