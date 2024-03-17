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
                  'Escala de desarrollo infantil',
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
                    IconContainer(url: 'assets/logos/logo-fenpidec.png', size: 140.0),
                    SizedBox(width: 20.0), // Añade un espacio entre los logos
                    IconContainer(url: 'assets/logos/logo-childfund.png', size: 140.0),
                  ],
                ),
                Divider(
                  height: 20.0,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 0.0,
                ),
                LoginForm()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
