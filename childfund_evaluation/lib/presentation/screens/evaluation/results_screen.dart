import 'package:childfund_evaluation/presentation/screens/age_selection_screen.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:childfund_evaluation/utils/models/age_group.dart';
import 'package:childfund_evaluation/utils/models/indicator.dart';
import 'package:childfund_evaluation/utils/models/indicator_with_level.dart';
import 'package:childfund_evaluation/utils/models/motor.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  final String selectedAge;
  final int selectedLevel;
  final String childAgeMonths;
  final double developmentCoeficient;
  final List<AgeGroup> ageGroups;

  const ResultsScreen(
      {super.key,
      required this.selectedAge,
      required this.selectedLevel,
      required this.childAgeMonths,
      required this.developmentCoeficient,
      required this.ageGroups});

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

  int getScore() {
    int score = 0;
    AgeGroup ageLevelSelected = widget.ageGroups
        .firstWhere((element) => element.level == widget.selectedLevel);
    score += countQuestions(ageLevelSelected);

    if (widget.selectedLevel > 1) {
      AgeGroup ageLevelLower = widget.ageGroups
          .firstWhere((element) => element.level == (widget.selectedLevel - 1));

      score -= countQuestions(ageLevelLower);
    }

    if (widget.selectedLevel < 11) {
      AgeGroup ageLevelUpper = widget.ageGroups
          .firstWhere((element) => element.level == (widget.selectedLevel + 1));
      score += countQuestions(ageLevelUpper);
    }
    return score;
  }

  int countQuestions(AgeGroup ageGroup) {
    int score = 0;
    for (var motor in ageGroup.motors) {
      for (var indicator in motor.indicators) {
        if (indicator.accomplished == true) {
          score++;
        }
      }
    }

    return score;
  }

  @override
  Widget build(BuildContext context) {
    List<Motor> allMotors = [];
    for (var ageGroup in widget.ageGroups) {
      if (ageGroup.level == widget.selectedLevel ||
          ageGroup.level == widget.selectedLevel - 1 ||
          ageGroup.level == widget.selectedLevel + 1) {
        allMotors.addAll(ageGroup.motors);
      }
    }

    Map<String, List<IndicatorWithLevel>> motorsDict = {};
    for (var ageGroup in widget.ageGroups) {
      if (ageGroup.level != widget.selectedLevel &&
          ageGroup.level != widget.selectedLevel - 1 &&
          ageGroup.level != widget.selectedLevel + 1) {
        continue;
      }
      for (var motor in ageGroup.motors) {
        int i = 1;
        for (var indicator in motor.indicators) {
          if (indicator.accomplished == null) {
            continue;
          }
          motorsDict
              .putIfAbsent(motor.motorName, () => [])
              .add(IndicatorWithLevel(indicator, ageGroup.level, i));
          i++;
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Resultados'),
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
              Text("Total de puntos: ${getScore()}"),
              Expanded(
                child: ResultsListWidget(
                  motorsDict: motorsDict,
                  selectedLevel: widget.selectedLevel,
                ),
              ),
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

class ResultsListWidget extends StatelessWidget {
  final Map<String, List<IndicatorWithLevel>> motorsDict;
  final int selectedLevel;

  const ResultsListWidget(
      {Key? key, required this.motorsDict, required this.selectedLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: motorsDict.length,
      itemBuilder: (context, index) {
        final motorName = motorsDict.keys.toList()[index];
        final indicatorsWithLevels = motorsDict[motorName]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Motor: $motorName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: indicatorsWithLevels.map((indicatorWithLevel) {
                final indicator = indicatorWithLevel.indicator;
                final level = indicatorWithLevel.level;
                var accomplishedStatus =
                    indicator.accomplished == true ? '1' : '0';

                return Text(
                  'Pregunta: ${indicator.indicator ?? ""} / Nivel $level / ${selectedLevel - 1 == level ? "-" : accomplishedStatus == "0" ? "" : "+"}$accomplishedStatus',
                  style: TextStyle(fontStyle: FontStyle.italic),
                );
              }).toList(),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
