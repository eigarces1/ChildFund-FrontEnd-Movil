import 'package:childfund_evaluation/presentation/screens/evaluator/results_screen.dart';
import 'package:childfund_evaluation/utils/json_parse.dart';
import 'package:childfund_evaluation/utils/models/age_group.dart';
import 'package:childfund_evaluation/utils/models/age_group_parent.dart';
import 'package:childfund_evaluation/utils/models/indicator.dart';
import 'package:childfund_evaluation/utils/models/motor.dart';
import 'package:childfund_evaluation/utils/models/tarea.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../widgets/child_evaluation_form.dart';

class EvaluationParentScreen extends StatefulWidget {
  final String selectedAge;
  final int selectedLevel;
  final String childAgeMonths;

  const EvaluationParentScreen(
      {super.key,
      required this.selectedAge,
      required this.selectedLevel,
      required this.childAgeMonths});

  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationParentScreen> {
  int currentQuestionIndex = 0;
  int currentStep = 0;
  int currentMotorIndex = 0;
  bool isLowerLevel = false;
  bool isUpperLevel = false;
  Tarea? currentTask;
  AgeGroupParent? currentAgeGroup;
  int score = 0;
  List<AgeGroupParent> ageGroupsData = [];
  List<List<int>> coeficientTable = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      List<AgeGroupParent> data = await loadTasksJsonData();
      List<List<int>> dataCoeficent = await loadCoeficientTable();

      AgeGroupParent currentAgeGroupData =
          data.firstWhere((ageGroup) => ageGroup.level == widget.selectedLevel);

      setState(() {
        coeficientTable = dataCoeficent;
        ageGroupsData = data;
        currentAgeGroup = currentAgeGroupData;
        currentTask = currentAgeGroup?.tareas[currentMotorIndex];
      });
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  /*List<Step> getCurrentTaskStep() {
    List<Tarea> tasksToUse = isLowerLevel
        ? currentAgeGroup!.tareas.reversed.toList()
        : currentAgeGroup!.tareas;

    List<Step> steps = tasksToUse.asMap().entries.map((entry) {
      final index = entry.key;
      final task = entry.value;
      return Step(
        isActive: true,
        state: currentStep == index
        ? StepState.editing
        : index < currentStep
          ? StepState.complete
          : StepState.indexed,
        title: const Text(""),
        content: ChildEvaluationFormWidget(

        )
      )
    });
  }*/

  void updateStepAccomplished(Indicator indicator, bool value) {
    setState(() {
      indicator.accomplished = value;
    });
  }

  String getValueStringMaterials(String? value) {
    if (value != null) {
      return value;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista con Listas Internas'),
      ),
      body: ListView.builder(
        itemCount: ageGroupsData.length,
        itemBuilder: (context, index) {
          final item = ageGroupsData![index];
          return ListTile(
            title: Text(item.range),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                item.tareas.length,
                (i) {
                  final subItem = item.tareas[i];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subItem.indicador),
                      Text(getValueStringMaterials(subItem.materiales)),
                      Text(subItem.instrucciones),
                      Divider(), // Añadir separador entre elementos
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
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

  double getDevelopmentCoeficient(int scoreObtained) {
    return coeficientTable[scoreObtained][int.parse(widget.childAgeMonths) - 1]
        .toDouble();
  }

  int getExpectedScore() {
    double ageInMonths = double.tryParse(widget.childAgeMonths) == null
        ? 0
        : double.parse(widget.childAgeMonths);
    if (ageInMonths >= 9) {
      return 30;
    } else if (ageInMonths >= 8) {
      return 25;
    } else if (ageInMonths >= 7) {
      return 20;
    } else if (ageInMonths >= 6) {
      return 15;
    } else if (ageInMonths >= 5) {
      return 10;
    } else {
      return 5;
    }
  }
}
