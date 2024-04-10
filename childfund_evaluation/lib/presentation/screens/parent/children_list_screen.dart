import 'dart:async';

import 'package:childfund_evaluation/preference/prefs.dart';
import 'package:childfund_evaluation/presentation/screens/login/sing_in.dart';
import 'package:childfund_evaluation/presentation/screens/parent/child_details_screen.dart';
import 'package:childfund_evaluation/presentation/widgets/message_box.dart';
import 'package:childfund_evaluation/system/globals.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:childfund_evaluation/utils/controllers/net_controller.dart';
import 'package:flutter/material.dart';
import '../../../utils/api_service.dart';
import '../../../utils/models/child.dart'; // Importa la clase Child
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ChildrenListPage extends StatefulWidget {
  const ChildrenListPage({Key? key}) : super(key: key);

  @override
  _ChildrenListPageState createState() => _ChildrenListPageState();
}

class _ChildrenListPageState extends State<ChildrenListPage> {
  List<Map<String, dynamic>>? children;
  List<dynamic>? childrenLocalStg;
  List<dynamic>? childrenInfoData;
  Storage stg = new Storage();
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  bool hasInternet = false;
  NetController netController = new NetController();

  @override
  void initState() {
    super.initState();
    _loadChildren();
    subscription = Connectivity().onConnectivityChanged.listen(_showState);
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
    });
  }

  bool _showState(ConnectivityResult result) {
    final hasInternet = this.netController.isConected(result);
    print('Is Conected? : ${hasInternet}');
    return hasInternet;
  }

  Future<void> _loadChildren() async {
    if (hasInternet) {
      final childrenData = await ApiService.getChildrenByParentId(
          paGlobal.parentId, tokenGlobal);
      setState(() {
        children = childrenData;
      });
    } else {
      stg.obtenerChildrenList().then((value) {
        setState(() {
          childrenLocalStg = value;
        });
      });
      stg.obtenerInfoChildList().then((value) {
        setState(() {
          childrenInfoData = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de hijos'),
        backgroundColor: AppColors.primaryColor,
        //automaticallyImplyLeading: false,
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
      body: hasInternet
          ? children == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: children!.length,
                  itemBuilder: (context, index) {
                    final child = children![index];
                    return ListTile(
                      title: Text(
                          '${child['name'] ?? ''} ${child['lastname'] ?? ''}'),
                      subtitle: Text(
                          'Género: ${child['gender'] ?? ''}, Fecha de nacimiento: ${child['birthdate'] ?? ''}'),
                      onTap: () {
                        _navigateToChildDetails(child['child_id']);
                        //child['test_id']); // Navegar a la página de detalles del niño al hacer clic
                      },
                    );
                  },
                )
          : childrenLocalStg == null
              ? Center(child: CircularProgressIndicator())
              : Stack(children: <Widget>[
                  SnackMessage(),
                  ListView.builder(
                    itemCount: childrenLocalStg!.length,
                    itemBuilder: (context, index) {
                      final child = childrenLocalStg![index];
                      return ListTile(
                        title: Text(
                            '${child['name'] ?? ''} ${child['lastname'] ?? ''}'),
                        subtitle: Text(
                            'Género: ${child['gender'] ?? ''}, Fecha de nacimiento: ${child['birthdate'] ?? ''}'),
                        onTap: () {
                          _navigateToChildDetailsOffline(child['child_id']);
                          //child['test_id']); // Navegar a la página de detalles del niño al hacer clic
                        },
                      );
                    },
                  )
                ]),
    );
  }

  void _navigateToChildDetailsOffline(int id) {
    Child? childOff = getOffLineDataChildren(id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChildDetailsPage(
          child: childOff!,
          //testId: testId,
        ), // Pasa el niño seleccionado a la página de detalles
      ),
    );
  }

  void _navigateToChildDetails(int id) {
    Future<dynamic> childOne = _getChild(id);

    childOne.then((ch) {
      if (ch is Child) {
        Child children = ch;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChildDetailsPage(
              child: children,
              //testId: testId,
            ), // Pasa el niño seleccionado a la página de detalles
          ),
        );
      } else {
        print('Niño no encontrado');
      }
    });
  }

  Future<dynamic> _getChild(int id) async {
    return ApiService.getChildrenById(id);
  }

  Child? getOffLineDataChildren(int id) {
    for (int i = 0; i < childrenInfoData!.length; i++) {
      if (childrenInfoData![i].childId == id) {
        return childrenInfoData![i];
      }
    }
    return null;
  }
}
