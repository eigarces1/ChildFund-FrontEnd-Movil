import 'dart:convert';

import 'package:childfund_evaluation/presentation/screens/login/sing_in.dart';
import 'package:childfund_evaluation/presentation/screens/parent/children_list_screen.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:childfund_evaluation/utils/models/parent.dart';
import 'package:flutter/material.dart';
import 'package:childfund_evaluation/system/globals.dart';
import 'package:childfund_evaluation/preference/prefs.dart';

class ParentPage extends StatelessWidget {
  const ParentPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Storage stg = new Storage();
    stg.obtenerPadre().then((Parent? p) {
      print('Data guardada => ');
      print(p!.getData());
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Padre'),
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading:
              false, // Esta línea evita que aparezca la flecha de retroceso
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  // Limpia el token al cerrar la sesión
                  tokenGlobal = '';
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
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Hola ${paGlobal.name} ${paGlobal.lastname}',
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
                        MaterialPageRoute(
                            builder: (context) => ChildrenListPage()),
                      );
                    },
                    child: const Text('Mis hijos'))
              ],
            )));
  }
}
