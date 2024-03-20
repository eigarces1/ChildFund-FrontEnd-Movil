//PANTALLA PARA ELEGIR UN RANGO DE EDAD E INICIAR LA EVALUACION CORRESPONDIENTE

import 'package:flutter/material.dart';
import './evaluator/evaluation_screen.dart';
import 'package:childfund_evaluation/utils/colors.dart';

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
  String anio = '0';
  String mes = '0';
  String dia = '0';

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

      if (currentDate.isBefore(picked)) {
        print('La fecha seleccionada debe ser anterior a la fecha actual');
        return;
      }
      int years = currentDate.year - picked.year;
      int months = currentDate.month - picked.month;
      int days = currentDate.day - picked.day;

      if (months < 0 || (months == 0 && days < 0)) {
        years--;
        months += 12;
      }

      if (days < 0) {
        DateTime previousMonth =
            DateTime(currentDate.year, currentDate.month, 0);
        days += previousMonth.day;
        months--;

        if (months < 0) {
          years--;
          months += 12;
        }
      }

      int differenceInDays = years * 360 + months * 30 + days;
      print(differenceInDays);
      int differenceInMonths = differenceInDays ~/ 30;
      int meses = differenceInMonths;
      print(meses);
      int remainingDays = differenceInDays % 30;

      if (remainingDays > 0) {
        differenceInMonths++;
      }

      int level = calculateLevel(differenceInMonths.toDouble());

      setState(() {
        _selectedDate = picked;
        numberOfDays = differenceInDays;
        childAgeMonths = '$differenceInMonths';
        mes = meses.toString(); // Convertir a String
        dia = days.toString(); // Convertir a String
        selectedLevel = level;
        selectedAge = ageLevelMapReversed[level]!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de nivel'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Text(
                'Seleccione la edad del infante',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Seleccione la fecha'),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Text(
                    'Fecha de nacimiento: ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_selectedDate?.year}-${_selectedDate?.month}-${_selectedDate?.day}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              if (numberOfDays != null)
                Row(
                  children: [
                    Text(
                      'Meses calculados: ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$mes meses con $dia días',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              Row(
                children: [
                  Text(
                    'Nivel calculado: ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$selectedLevel',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
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
                        testId: 1,
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
