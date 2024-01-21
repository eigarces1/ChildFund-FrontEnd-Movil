// MAIN

import 'package:flutter/material.dart';
import 'presentation/screens/age_selection_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AgeSelectionScreen(),
    );
  }
}