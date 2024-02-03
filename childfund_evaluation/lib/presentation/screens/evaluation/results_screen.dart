import 'package:childfund_evaluation/presentation/screens/age_selection_screen.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  final String selectedAge;
  final int selectedLevel;
  final String childAgeMonths;
  final double developmentCoeficient;

  const ResultsScreen(
      {super.key,
      required this.selectedAge,
      required this.selectedLevel,
      required this.childAgeMonths,
      required this.developmentCoeficient});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  String getInterpretation() {
    double score = widget.developmentCoeficient;
    if (score >= 130) {
      return "Muy Avanzado";
    } else if (score >= 110) {
      return "Avanzado";
    } else if (score >= 90) {
      return "Normal";
    } else if (score >= 70) {
      return "Bajo";
    } else {
      return "En riesgo";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Resultados - ${widget.selectedAge}'),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Resultados",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Text(
                  "Coeficiente de desarrollo obtenido: ${widget.developmentCoeficient.toInt()}"),
              Text("Interpretación: ${getInterpretation()}"),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AgeSelectionScreen(),
                    ),
                    (route) => false, // This makes sure all routes are removed
                  );
                },
                child: const Text('Volver a Inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
