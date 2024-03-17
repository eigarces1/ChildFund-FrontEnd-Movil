import 'package:flutter/material.dart';

class InformationParent extends StatefulWidget {
  const InformationParent({super.key});

  @override
  State<InformationParent> createState() => _InformationParentState();
}

class _InformationParentState extends State<InformationParent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }
}