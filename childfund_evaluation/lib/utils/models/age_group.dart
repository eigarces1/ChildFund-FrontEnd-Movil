import 'package:childfund_evaluation/utils/models/motor.dart';

class AgeGroup {
  final int level;
  final String range;
  final List<Motor> motors;

  const AgeGroup(
      {required this.level, required this.range, required this.motors});
}
