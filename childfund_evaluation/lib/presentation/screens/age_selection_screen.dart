//PANTALLA PARA ELEGIR UN RANGO DE EDAD E INICIAR LA EVALUACION CORRESPONDIENTE

import 'package:flutter/material.dart';
import 'evaluation/evaluation_screen.dart';

class AgeSelectionScreen extends StatefulWidget {
  const AgeSelectionScreen({Key? key}) : super(key: key);

  @override
  _AgeSelectionScreenState createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  String selectedAge = '0 a 3 meses';
  int selectedLevel = 1;
  String childAgeMonths = '';

  final Map<String, int> ageLevelMap = {
    '0 a 3 meses': 1,
    '3.1 a 6 meses': 2,
    '6.1 a 9 meses': 3,
    '9.1 a 12 meses': 4,
    '12.1 a 16 meses': 5,
    '16.1 a 20 meses': 6,
    '20.1 a 24 meses': 7,
    '24.1 a 36 meses': 8,
    '36.1 a 48 meses': 9,
    '48.1 a 60 meses': 10,
    '60.1 a 72 meses': 11,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccione el Rango de Edad'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ingrese la edad del niño en meses:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Edad del niño en meses',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    childAgeMonths = value;
                    selectedLevel = calculateLevel(
                        int.tryParse(value) == null ? 0 : int.parse(value));
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Nivel calculado: $selectedLevel',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EvaluationScreen(
                        selectedAge: selectedAge,
                        selectedLevel: selectedLevel,
                        childAgeMonths: childAgeMonths,
                      ),
                    ),
                  );
                },
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int calculateLevel(int ageInMonths) {
    // Perform calculations to determine the level based on the child's age
    if (ageInMonths >= 60.1) {
      return 11;
    } else if (ageInMonths >= 48.1) {
      return 10;
    } else if (ageInMonths >= 36.1) {
      return 9;
    } else if (ageInMonths >= 24.1) {
      return 8;
    } else if (ageInMonths >= 20.1) {
      return 7;
    } else if (ageInMonths >= 16.1) {
      return 6;
    } else if (ageInMonths >= 12.1) {
      return 5;
    } else if (ageInMonths >= 9.1) {
      return 4;
    } else if (ageInMonths >= 6.1) {
      return 3;
    } else if (ageInMonths >= 3.1) {
      return 2;
    } else {
      return 1;
    }
  }
}
