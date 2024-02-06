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
  DateTime? _selectedDate = DateTime.now();
  int? numberOfDays;

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

  final Map<int, String> ageLevelMapReversed = {
    1: '0 a 3 meses',
    2: '3.1 a 6 meses',
    3: '6.1 a 9 meses',
    4: '9.1 a 12 meses',
    5: '12.1 a 16 meses',
    6: '16.1 a 20 meses',
    7: '20.1 a 24 meses',
    8: '24.1 a 36 meses',
    9: '36.1 a 48 meses',
    10: '48.1 a 60 meses',
    11: '60.1 a 72 meses',
  };
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      DateTime currentDate = DateTime.now();
      int differenceInDays = currentDate.difference(picked).inDays;

      int months = differenceInDays ~/ 30; // Calculate the number of months
      int remainingDays = differenceInDays % 30; // Calculate the remaining days

      if (remainingDays > 0) {
        months++; // Increment the number of months if there are remaining days
      }

      int level = calculateLevel(months.toDouble());

      setState(() {
        _selectedDate = picked;
        numberOfDays = differenceInDays;
        childAgeMonths = '$months';
        selectedLevel = level;
        selectedAge = ageLevelMapReversed[level]!;
      });
    }
  }

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
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child:
                    const Text('Seleccione la fecha de nacimiento del infante'),
              ),
              const SizedBox(height: 32),
              Text(
                'Fecha de nacimiento: ${_selectedDate?.year}-${_selectedDate?.month}-${_selectedDate?.day}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (numberOfDays != null)
                Text(
                  'Dias calculados $numberOfDays dias',
                  style: const TextStyle(fontSize: 16),
                ),
              Text(
                'Nivel calculado: $selectedLevel',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
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

  int calculateLevel(double ageInMonths) {
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
