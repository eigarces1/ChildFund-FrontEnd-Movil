import 'package:childfund_evaluation/presentation/screens/login/sing_in.dart';
import 'package:childfund_evaluation/presentation/screens/parent/success_results.dart';
import 'package:childfund_evaluation/system/globals.dart';
import 'package:childfund_evaluation/utils/api_service.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:childfund_evaluation/utils/controllers/parent_results_convert.dart';
import 'package:childfund_evaluation/utils/models/age_group_parent.dart';
import 'package:childfund_evaluation/utils/models/tarea.dart';
import 'package:childfund_evaluation/utils/models/task_with_level.dart';
import 'package:flutter/material.dart';

class ResultsParentsScreen extends StatefulWidget {
  final String selectedAge;
  final int selectedLevel;
  final String childAgeMonths;
  final double developmentCoeficient;
  final List<AgeGroupParent>? ageGroups;
  final int testId;

  const ResultsParentsScreen({
    super.key,
    required this.selectedAge,
    required this.selectedLevel,
    required this.childAgeMonths,
    required this.developmentCoeficient,
    this.ageGroups,
    required this.testId,
  });

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsParentsScreen> {
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
    AgeGroupParent ageLevelSelected = widget.ageGroups!
        .firstWhere((element) => element.level == widget.selectedLevel);
    score += countQuestions(ageLevelSelected);

    if (widget.selectedLevel > 1) {
      AgeGroupParent ageLevelLower = widget.ageGroups!
          .firstWhere((element) => element.level == (widget.selectedLevel - 1));

      score -= countQuestions(ageLevelLower);
    }

    if (widget.selectedLevel < 11) {
      AgeGroupParent ageLevelUpper = widget.ageGroups!
          .firstWhere((element) => element.level == (widget.selectedLevel + 1));
      score += countQuestions(ageLevelUpper);
    }
    return score;
  }

  int countQuestions(AgeGroupParent ageGroup) {
    int score = 0;
    for (var motor in ageGroup.tareas) {
      if (motor.accomplished == true) {
        score++;
      }
    }

    return score;
  }

  @override
  Widget build(BuildContext context) {
    List<Tarea> allMotors = [];
    for (var ageGroup in widget.ageGroups!) {
      if (ageGroup.level == widget.selectedLevel ||
          ageGroup.level == widget.selectedLevel - 1 ||
          ageGroup.level == widget.selectedLevel + 1) {
        allMotors.addAll(ageGroup.tareas);
      }
    }

    Map<String, List<TaskWithLevel>> motorsDict = {};
    for (var ageGroup in widget.ageGroups!) {
      if (ageGroup.level != widget.selectedLevel &&
          ageGroup.level != widget.selectedLevel - 1 &&
          ageGroup.level != widget.selectedLevel + 1) {
        continue;
      }
      for (var motor in ageGroup.tareas) {
        int i = 1;
        if (motor.accomplished == null) {
          continue;
        }
        motorsDict
            .putIfAbsent(motor.indicador, () => [])
            .add(TaskWithLevel(motor, ageGroup.level, i));
        i++;
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Resultados'),
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading:
              false, // Esta línea evita que aparezca la flecha de retroceso
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  // Limpia el token al cerrar la sesión
                  tokenGlobal = '';
                  // Navega a la pantalla de inicio de sesión
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SingIn()),
                    (route) => false,
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Cerrar sesión'),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const Text(
                "Resultados",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Text("Total de puntos: ${getScore()}"),
              const SizedBox(height: 6),
              const Text("Puntos obtenidos",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Expanded(
                child: ResultsListWidget(
                  motorsDict: motorsDict,
                  selectedLevel: widget.selectedLevel,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ParentConverter controller =
                      ParentConverter(motorsDict: motorsDict);
                  String jsonData = controller.convertToJson();
                  ApiService.submitResultsParents(jsonData, widget.testId);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessParent(),
                    ),
                    (route) => false, // This makes sure all routes are removed
                  );
                },
                child: const Text('Enviar'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultsListWidget extends StatelessWidget {
  final Map<String, List<TaskWithLevel>> motorsDict;
  final int selectedLevel;

  const ResultsListWidget({
    Key? key,
    required this.motorsDict,
    required this.selectedLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: 600.0), // Ajusta según tus necesidades
        child: Center(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: motorsDict.length,
            itemBuilder: (context, index) {
              final motorName = motorsDict.keys.toList()[index];
              final indicatorsWithLevels = motorsDict[motorName]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Tarea: $motorName',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: indicatorsWithLevels.map((indicatorWithLevel) {
                      final indicator = indicatorWithLevel.indicator;
                      final level = indicatorWithLevel.level;
                      var accomplishedStatus =
                          indicator.accomplished == true ? '1' : '0';

                      return Center(
                        child: Text(
                          'Pregunta: ${indicator.indicador ?? ""} / Nivel $level / ${selectedLevel - 1 == level ? "-" : accomplishedStatus == "0" ? "" : "+"}$accomplishedStatus',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      );
                    }).toList(),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
