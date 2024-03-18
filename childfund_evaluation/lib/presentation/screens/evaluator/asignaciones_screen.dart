import 'package:childfund_evaluation/utils/models/evaluator.dart';
import 'package:childfund_evaluation/utils/models/test.dart';
import 'package:flutter/material.dart';
import 'package:childfund_evaluation/utils/api_service.dart';
import 'package:childfund_evaluation/system/globals.dart';

class AsignacionesPage extends StatefulWidget {
  @override
  _AsignacionesState createState() => _AsignacionesState();
}

class _AsignacionesState extends State<AsignacionesPage> {
  Future<dynamic>? _data;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    List<Test> tests = [];
    _data = ApiService.getAsignaciones(evGlobal.officerId, tokenGlobal);
    _data?.then((data) {
      for (int i = 0; i < data.length; i++) {
        /*tests.add(Test(
            testId: data[i]['test_id'],
            childId: data[i]['child_id'],
            officerId: data[i]['officer_id'],
            responses: data[i]['responses'],
            developmentRatio: data[i]['development_ratio'],
            updated: data[i]['updated_at'],
            created: data[i]['created_at'],
            childName: data[i]['child_name'],
            cildLastname: data[i]['child_lastname'],
            stage: data[i]['stage'],
            assignedDate: data[i]['assigned_date']));*/
        print(data[i]);
      }
    });
    print("TESTS:");
    print(tests);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'hola jijij',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(evGlobal.rol),
                const Divider(),
                const SizedBox(height: 8.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AsignacionesPage()),
                      );
                    },
                    child: const Text('Mis asignaciones'))
              ],
            )));
  }
}
