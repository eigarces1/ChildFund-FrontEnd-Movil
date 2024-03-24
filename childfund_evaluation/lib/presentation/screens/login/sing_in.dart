import 'package:childfund_evaluation/presentation/widgets/icon_container.dart';
import 'package:childfund_evaluation/presentation/widgets/login_form.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:flutter/material.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.whiteColor,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  'Escala de desarrollo infantil',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 2.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconContainer(url: 'assets/logos/logo-fenpidec.png', size: 140.0),
                    SizedBox(width: 20.0), // Añade un espacio entre los logos
                    IconContainer(url: 'assets/logos/logo-childfund.png', size: 140.0),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                LoginForm()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
