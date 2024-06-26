import 'package:childfund_evaluation/preference/prefs.dart';
import 'package:childfund_evaluation/presentation/screens/login/sing_in.dart';
import 'package:childfund_evaluation/presentation/screens/parent/evaluation_end_screen.dart';
import 'package:childfund_evaluation/system/globals.dart';
import 'package:childfund_evaluation/utils/json_parse.dart';
import 'package:childfund_evaluation/utils/models/age_group_parent.dart';
import 'package:childfund_evaluation/utils/models/tarea.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../widgets/parent_evaluation_form.dart';

class EvaluationParentRestHalfTaskScreen extends StatefulWidget {
  final String selectedAge;
  final int selectedLevel;
  final String childAgeMonths;
  final int testId;
  List<AgeGroupParent>? ageGroupsData;

  EvaluationParentRestHalfTaskScreen(
      {super.key,
      required this.selectedAge,
      required this.selectedLevel,
      required this.childAgeMonths,
      required this.testId,
      this.ageGroupsData});

  @override
  _EvaluationRestScreenState createState() => _EvaluationRestScreenState();
}

class _EvaluationRestScreenState
    extends State<EvaluationParentRestHalfTaskScreen> {
  int currentQuestionIndex = 0;
  int currentStep = 0;
  int currentMotorIndex = 0;
  bool isLowerLevel = false;
  bool isUpperLevel = false;
  Tarea? currentTask;
  int score = 0;
  int tam = 0;
  AgeGroupParent? currentAgeGroup;
  List<AgeGroupParent>? ageGroupsData2;
  List<AgeGroupParent>? ageGroupsDataAux;
  Storage stg = Storage();
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
        ageGroupsData2 = data;
        currentAgeGroup = currentAgeGroupData;
        currentTask = currentAgeGroup?.tareas[currentMotorIndex];
      });
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  Map<String, String> imagesRoute = {
    "1": "0-3 meses",
    "2": "3-6 meses",
    "3": "6-9 meses",
    "4": "9-12 meses",
    "5": "12-16 meses",
    "6": "16-20 meses",
    "7": "20-24 meses",
    "8": "24-36 meses",
    "9": "36-48 meses",
    "10": "48-60 meses",
    "11": "60-72 meses",
  };

  List<Step> getCurrentTaskStep() {
    //halfSteps
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
        content: ParentEvaluationFormWidget(
          indicator: task.indicador,
          image: task.imagen,
          level:
              '${!isLowerLevel ? !isUpperLevel ? widget.selectedLevel : widget.selectedLevel + 1 : widget.selectedLevel - 1}',
          materiales: getValueStringMaterials(task.materiales),
          instrucciones: task.instrucciones,
          accomplished: task.accomplished,
          onChanged: (value) {
            updateStepAccomplished(task, value!);
          },
          imagesRoute: imagesRoute,
        ),
      );
    }).toList();

    stepsGlobal = steps;
    return stepsGlobal;
  }

  List<Step> getRestHalfSteps() {
    getCurrentTaskStep();
    List<Step> lista =
        stepsGlobal.sublist((stepsGlobal.length ~/ 2), stepsGlobal.length);
    return lista;
  }

  void updateStepAccomplished(Tarea task, bool value) {
    setState(() {
      task.accomplished = value;
    });
  }

  int countAccomplishedIndicators() {
    if (currentAgeGroup == null) {
      return 0;
    }
    return currentAgeGroup!.tareas
        .where((indicator) => indicator.accomplished == true)
        .length;
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
    setState(() {
      tam = getCurrentTaskStep().length ~/ 2;
    });
    // Check if currentMotor is null
    if (currentAgeGroup == null) {
      // Show a loading indicator or any other appropriate widget until currentMotor is initialized
      return const CircularProgressIndicator();
    } else {
      // Once currentMotor is initialized, build the Stepper widget
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Actividades'),
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading:
                false, // Esta línea evita que aparezca la flecha de retroceso
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    // Limpia el token al cerrar la sesión
                    tokenGlobal = '';
                    stg.eliminarDataParent('all');
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
          body: Column(
            children: [
              Expanded(
                child: Stepper(
                  steps: getCurrentTaskStep()
                      .sublist((stepsGlobal.length ~/ 2), stepsGlobal.length),
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepContinue: () {
                    final isLastStep = currentStep == tam - 1;

                    print("STEP => ${currentStep}");
                    List<Tarea> indicatorsToUse = isLowerLevel
                        ? currentAgeGroup!.tareas.reversed.toList()
                        : currentAgeGroup!.tareas;

                    if (isLastStep) {
                      int currentScore = countAccomplishedIndicators();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => /*ChildrenListPage()*/
                              ResultsParentsScreen(
                            selectedAge: widget.selectedAge,
                            selectedLevel: widget.selectedLevel,
                            childAgeMonths: widget.childAgeMonths,
                            developmentCoeficient:
                                getDevelopmentCoeficient(getScore()),
                            ageGroups:
                                (widget.ageGroupsData! + ageGroupsData2!),
                            testId: widget.testId,
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        currentStep += 1;
                      });
                    }
                  },
                  onStepCancel: currentStep == 0
                      ? null
                      : () => setState(() => currentStep -= 1),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  int getScore() {
    int score = 0;
    AgeGroupParent ageLevelSelected = ageGroupsData2!
        .firstWhere((element) => element.level == widget.selectedLevel);
    score += countQuestions(ageLevelSelected);

    if (widget.selectedLevel > 1) {
      AgeGroupParent ageLevelLower = ageGroupsData2!
          .firstWhere((element) => element.level == (widget.selectedLevel - 1));

      score -= countQuestions(ageLevelLower);
    }

    if (widget.selectedLevel < 11) {
      AgeGroupParent ageLevelUpper = ageGroupsData2!
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
