import 'package:flutter/material.dart';

class EvaluationScreen extends StatefulWidget {
  final String selectedAge;
  final int selectedLevel;

  EvaluationScreen({required this.selectedAge, required this.selectedLevel});

  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluación - ${widget.selectedAge}'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          // Aquí muestra la pregunta actual según la lógica de evaluación
          // Puedes usar switch - case para decidir qué preguntas mostrar
          // según el nivel y el área de desarrollo infantil
          Text(getCurrentQuestion()),
          // Botones de respuesta, lógica de respuesta, etc.
        ],
      ),
    );
  }

  String getCurrentQuestion() {
    // Lógica para obtener la pregunta actual
    // Puedes llamar a funciones en otros archivos para manejar la lógica específica del nivel y área

    // Aquí puedes usar switch - case para manejar diferentes niveles
    switch (widget.selectedLevel) {
      case 1:
        return getLevel1Question(currentQuestionIndex);
      case 2:
        // Lógica para el nivel 2
        break;
      // Añade más casos según sea necesario
    }

    return 'No hay más preguntas';
  }

  // Define la función getLevel1Question o cualquier otra función necesaria
  // para obtener preguntas según el nivel y el índice de pregunta.
  String getLevel1Question(int index) {
    // Implementa la lógica para obtener la pregunta del nivel 1.
    // Usa la variable 'index' para obtener la pregunta correspondiente.
    return 'Pregunta del nivel 1 - Pregunta $index';
  }
}
