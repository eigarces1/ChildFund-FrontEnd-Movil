import 'package:childfund_evaluation/presentation/screens/evaluation/results_screen.dart';
import 'package:childfund_evaluation/utils/json_parse.dart';
import 'package:childfund_evaluation/utils/models/age_group.dart';
import 'package:childfund_evaluation/utils/models/indicator.dart';
import 'package:childfund_evaluation/utils/models/motor.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../widgets/child_evaluation_form.dart';

class EvaluationScreen extends StatefulWidget {
  final String selectedAge;
  final int selectedLevel;
  final String childAgeMonths;

  const EvaluationScreen(
      {super.key,
      required this.selectedAge,
      required this.selectedLevel,
      required this.childAgeMonths});

  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  int currentQuestionIndex = 0;
  int currentStep = 0;
  int currentMotorIndex = 0;
  bool isLowerLevel = false;
  bool isUpperLevel = false;
  Motor? currentMotor;
  AgeGroup? currentAgeGroup;
  int score = 0;
  List<AgeGroup> ageGroupsData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      List<AgeGroup> data = await loadIndicatorsJsonData();

      AgeGroup currentAgeGroupData =
          data.firstWhere((ageGroup) => ageGroup.level == widget.selectedLevel);

      setState(() {
        ageGroupsData = data;
        currentAgeGroup = currentAgeGroupData;
        currentMotor = currentAgeGroup?.motors[currentMotorIndex];
      });
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  List<Step> getCurrentMotorStep() {
    List<Indicator> indicatorsToUse = isLowerLevel
        ? currentMotor!.indicators.reversed.toList()
        : currentMotor!.indicators;

    List<Step> steps = indicatorsToUse.map((indicator) {
      return Step(
        isActive:
            true, // You may set isActive conditionally based on your requirements
        title: const Text(""), // Use indicator data as title
        content: ChildEvaluationFormWidget(
          // Use indicator data to populate the content of the ChildEvaluationFormWidget
          indicator: indicator.indicator,
          image: indicator.image,
          level:
              '${!isLowerLevel ? !isUpperLevel ? widget.selectedLevel : widget.selectedLevel + 1 : widget.selectedLevel - 1}',
          motorName: currentMotor!.motorName,
          posicion: indicator.position,
          materiales: indicator.materials,
          instrucciones: indicator.instructions,
          respuesta: indicator.response,
          accomplished: indicator
              .accomplished, // Pass the value of accomplished to the ChildEvaluationFormWidget
          onChanged: (value) {
            updateStepAccomplished(indicator,
                value!); // Callback function to update the accomplished value
          },
        ),
      );
    }).toList();

    return steps;
  }

  void updateStepAccomplished(Indicator indicator, bool value) {
    setState(() {
      indicator.accomplished = value;
    });
  }

  int countAccomplishedIndicators() {
    if (currentMotor == null) {
      return 0;
    }

    return currentMotor!.indicators
        .where((indicator) => indicator.accomplished == true)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    // Check if currentMotor is null
    if (currentMotor == null) {
      // Show a loading indicator or any other appropriate widget until currentMotor is initialized
      return const CircularProgressIndicator();
    } else {
      // Once currentMotor is initialized, build the Stepper widget
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Evaluación'),
            backgroundColor: AppColors.primaryColor,
          ),
          body: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: StepperType.horizontal,
                  steps: getCurrentMotorStep(),
                  currentStep: currentStep,
                  onStepContinue: () {
                    final isLastStep =
                        currentStep == getCurrentMotorStep().length - 1;

                    List<Indicator> indicatorsToUse = isLowerLevel
                        ? currentMotor!.indicators.reversed.toList()
                        : currentMotor!.indicators;

                    final isCurrentStepCompleted =
                        indicatorsToUse[currentStep].accomplished != null;
                    if (!isCurrentStepCompleted) {
                      return;
                    }

                    if (isLastStep) {
                      if (currentMotorIndex >= 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultsScreen(
                              selectedAge: widget.selectedAge,
                              selectedLevel: widget.selectedLevel,
                              childAgeMonths: widget.childAgeMonths,
                              developmentCoeficient: getDevelopmentCoeficient(),
                            ),
                          ),
                        );
                        return;
                      }

                      int currentScore = countAccomplishedIndicators();
                      score += isLowerLevel ? -currentScore : currentScore;

                      if (isLowerLevel ||
                          isUpperLevel ||
                          (currentScore < 2 && widget.selectedLevel == 1) ||
                          (currentScore >= 2 && widget.selectedLevel == 11)) {
                        setState(() {
                          isLowerLevel = false;
                          isUpperLevel = false;
                          currentStep = 0;
                          currentMotorIndex += 1;
                          currentMotor =
                              currentAgeGroup?.motors[currentMotorIndex];
                        });
                        return;
                      }

                      if (currentScore >= 2 &&
                          widget.selectedLevel < 11 &&
                          !isUpperLevel) {
                        AgeGroup nextAgeGroup = ageGroupsData.firstWhere(
                            (ageGroup) =>
                                ageGroup.level == (widget.selectedLevel + 1));

                        setState(() {
                          isUpperLevel = true;
                          currentMotor = nextAgeGroup.motors[currentMotorIndex];
                          currentStep = 0;
                        });
                        return;
                      }
                      if (currentScore < 2 &&
                          widget.selectedLevel > 1 &&
                          !isLowerLevel) {
                        AgeGroup prevousAgeGroup = ageGroupsData.firstWhere(
                            (ageGroup) =>
                                ageGroup.level == (widget.selectedLevel - 1));

                        setState(() {
                          isLowerLevel = true;
                          currentMotor =
                              prevousAgeGroup.motors[currentMotorIndex];
                          currentStep = 0;
                        });
                        return;
                      }

                      //TO DO: save data
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

  double getDevelopmentCoeficient() {
    int expectedScore = getExpectedScore();
    // int chronologicalAgeInDays = int.parse(widget.childAgeMonths) * 30;
    // IDK the formula is weird af, this is simplified and chronological age is not needed
    return (score / expectedScore) * 100;
  }

  int getExpectedScore() {
    int ageInMonths = int.tryParse(widget.childAgeMonths) == null
        ? 0
        : int.parse(widget.childAgeMonths);
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
