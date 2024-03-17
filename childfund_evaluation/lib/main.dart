// MAIN

import 'package:childfund_evaluation/presentation/screens/login/home_page.dart';
import 'package:childfund_evaluation/presentation/screens/login/sing_in.dart';
import 'package:flutter/material.dart';
//import 'presentation/screens/age_selection_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Childfund Evaluation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const AgeSelectionScreen(),
      //home: const HomePage(),
      initialRoute: 'Home',
      routes: <String, WidgetBuilder>{
        'Home': (BuildContext context) => HomePage(),
        'sing_in': (BuildContext context) => SingIn()
      },
    );
  }
}
