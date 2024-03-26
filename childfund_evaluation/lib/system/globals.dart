library globales;

import 'package:childfund_evaluation/utils/models/evaluator.dart';
import 'package:childfund_evaluation/utils/models/parent.dart';
import 'package:flutter/material.dart';

/*
* Variable global para el evaluador
 */
Evaluator evGlobal = Evaluator.vacio();
Parent paGlobal = Parent.vacio();
String tokenGlobal = '';
List<Step> stepsGlobal = [];
