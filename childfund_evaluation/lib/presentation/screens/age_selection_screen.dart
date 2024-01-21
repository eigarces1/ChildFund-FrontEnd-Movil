//PANTALLA PARA ELEJIR UN RANGO DE EDAD E INICIAR LA EVALUACION CORRESPONDIENTE

import 'package:flutter/material.dart';
import 'evaluation/evaluation_screen.dart';

class AgeSelectionScreen extends StatefulWidget {
  @override
  _AgeSelectionScreenState createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  String selectedAge = '0 a 3 meses';
  int selectedLevel = 1; // Inicializa con el nivel correspondiente al primer rango

  // Define un mapa que asocie cada rango con su nivel
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
        title: Text('Seleccione el Rango de Edad'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Seleccione el rango de edad del infante:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              buildAgeDropdown(),
              SizedBox(height: 16),
              Text(
                'Nivel seleccionado: $selectedLevel',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32), // Agrega un espacio entre el texto y el botón
              ElevatedButton(
                onPressed: () {
                  // Navegar a la pantalla de evaluación al presionar el botón
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EvaluationScreen(
                        selectedAge: selectedAge,
                        selectedLevel: selectedLevel,
                      ),
                    ),
                  );
                },
                child: Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAgeDropdown() {
    final ageOptions = [
      '0 a 3 meses',
      '3.1 a 6 meses',
      '6.1 a 9 meses',
      '9.1 a 12 meses',
      '12.1 a 16 meses',
      '16.1 a 20 meses',
      '20.1 a 24 meses',
      '24.1 a 36 meses',
      '36.1 a 48 meses',
      '48.1 a 60 meses',
      '60.1 a 72 meses',
    ];

    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurpleAccent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedAge,
          icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple, fontSize: 16),
          onChanged: (String? value) {
            setState(() {
              selectedAge = value!;
              selectedLevel = ageLevelMap[selectedAge]!;
            });
            print(selectedAge);
          },
          items: ageOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                child: Text(value),
              ),
            );
          }).toList(),
          isExpanded: true,
          selectedItemBuilder: (BuildContext context) {
            return ageOptions.map<Widget>((String item) {
              return Center(
                child: Text(item),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
