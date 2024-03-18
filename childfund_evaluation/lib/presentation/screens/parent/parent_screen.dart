import 'package:childfund_evaluation/presentation/screens/parent/children_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:childfund_evaluation/system/globals.dart';

class ParentPage extends StatelessWidget {
  const ParentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parentId = paGlobal.parentId;
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Hola ' + paGlobal.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(paGlobal.rol),
                const Divider(),
                const SizedBox(height: 8.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChildrenListPage(parentId: parentId,)),
                    );
                    }, 
                    child: const Text('Mis hijos'))
              ],
            )));
  }
}
