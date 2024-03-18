import 'package:childfund_evaluation/utils/models/tarea.dart';

class AgeGroupParent {
  final int level;
  final String range;
  final List<Tarea> tareas;

  const AgeGroupParent(
      {required this.level, required this.range, required this.tareas});
}
