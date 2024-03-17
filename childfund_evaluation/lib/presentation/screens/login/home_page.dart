import 'package:childfund_evaluation/presentation/screens/login/sing_in.dart';
import 'package:childfund_evaluation/presentation/widgets/icon_container.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              AppColors.primaryColor,
              AppColors.whiteColor,
            ],
            begin: Alignment.topCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'BIENVENIDO',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
                SizedBox(height: 2.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconContainer(
                        url: 'assets/logos/logo-fenpidec.png', size: 140.0),
                    SizedBox(width: 20.0), // Añade un espacio entre los logos
                    IconContainer(
                        url: 'assets/logos/logo-childfund.png', size: 140.0),
                  ],
                ),
                Divider(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60.0,
                  child: MaterialButton(
                    color: AppColors.primaryColor,
                    onPressed: () {
                      final route =
                          MaterialPageRoute(builder: (context) => SingIn());
                      Navigator.push(context, route);
                    },
                    child: Text(
                      'Ingresar',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
