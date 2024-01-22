import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../widgets/child_evaluation_form.dart';

class EvaluationScreen extends StatefulWidget {
  final String selectedAge;
  final int selectedLevel;

  const EvaluationScreen(
      {required this.selectedAge, required this.selectedLevel});

  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  int currentQuestionIndex = 0;
  int currentStep = 0;

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: const Text(''),
          content: const ChildEvaluationFormWidget(
            posicion: "Acostado boca abajo.",
            materiales:
                "Manta o cobija lavable, sonajero o maraca pequeña, 10 juguetes de colores brillantes no menores de 5 cm.",
            instrucciones:
                "El examinador muestra un objeto llamativo distante de 30 cm, en la línea de su media cara. Cuando el niño mira al objeto, desplazarlo lentamente de izquierda a derecha y de abajo hacia arriba.",
            respuesta:
                "El niño sigue al objeto con los ojos y la cabeza en la misma dirección em que se lo mueve, por lo menos 3 veces.",
          ),
        ),
        Step(
            isActive: currentStep >= 1,
            title: const Text(''),
            content: Container()),
        Step(
            isActive: currentStep >= 2,
            title: const Text(''),
            content: Container())
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Evaluación - ${widget.selectedAge}'),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              print('Completed');
              //TO DO: save data
            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
        ),
        // body: Column(
        //   children: [
        //     // Aquí muestra la pregunta actual según la lógica de evaluación
        //     // Puedes usar switch - case para decidir qué preguntas mostrar
        //     // según el nivel y el área de desarrollo infantil
        //     Text(getCurrentQuestion()),
        //     // Botones de respuesta, lógica de respuesta, etc.
        //   ],
        // ),
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
