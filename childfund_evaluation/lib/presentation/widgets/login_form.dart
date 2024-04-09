import 'package:flutter/material.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:childfund_evaluation/utils/models/evaluator.dart';
import 'package:childfund_evaluation/utils/models/parent.dart';
import 'package:childfund_evaluation/utils/api_service.dart';
import 'package:childfund_evaluation/presentation/screens/evaluator/evaluator_screen.dart';
import 'package:childfund_evaluation/presentation/screens/parent/parent_screen.dart';
import 'package:childfund_evaluation/system/globals.dart';
import 'package:childfund_evaluation/preference/prefs.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formkey = GlobalKey();
  late String _email = '';
  late String _password = '';
  Storage stg = new Storage();

  Future<void> _submit() async {
    if (_formkey.currentState!.validate()) {
      final token = await ApiService.signIn(_email, _password);

      if (token != null) {
        // Manejar el éxito del inicio de sesión aquí
        print('Token recibido: $token');
        tokenGlobal = token;
        Future<dynamic> user = _getMe(token);
        user.then((userData) {
          if (userData is Evaluator) {
            Evaluator evaluator = userData;
            evGlobal.name = evaluator.name;
            evGlobal.lastname = evaluator.lastname;
            evGlobal.identificacion = evaluator.identificacion;
            evGlobal.mail = evaluator.mail;
            evGlobal.phone = evaluator.phone;
            evGlobal.position = evaluator.position;
            evGlobal.rol = evaluator.rol;
            evGlobal.userId = evaluator.userId;
            evGlobal.officerId = evaluator.officerId;
            print(evGlobal.getData());
            //this.stg.guardarDatosUsuario(evGlobal, null);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EvaluatorPage()),
            );
          } else if (userData is Parent) {
            Parent parent = userData;
            paGlobal.name = parent.name;
            paGlobal.lastname = parent.lastname;
            paGlobal.identificacion = parent.identificacion;
            paGlobal.mail = parent.mail;
            paGlobal.phone = parent.phone;
            paGlobal.position = parent.position;
            paGlobal.rol = parent.rol;
            paGlobal.userId = parent.userId;
            paGlobal.parentId = parent.parentId;
            stg.guardarPadre(paGlobal);
            stg.guardarListadoHijos(paGlobal, token);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ParentPage()),
            );
          } else {
            print('Usuario no reconocido');
          }
        });
      } else {
        // Manejar el error del inicio de sesión aquí
        print("hola -> error");
      }
    }
  }

  Future<dynamic> _getMe(String t) async {
    return ApiService.getMe(t);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Ingrese su correo electrónico',
              labelText: 'Correo electrónico',
              icon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Email inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Ingrese su contraseña',
              labelText: 'Contraseña',
              icon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Contraseña inválida';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
              ),
              onPressed: _submit,
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
    );
  }
}
