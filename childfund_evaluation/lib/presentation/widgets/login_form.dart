import 'package:childfund_evaluation/presentation/widgets/input_text.dart';
import 'package:childfund_evaluation/utils/api_service.dart';
import 'package:childfund_evaluation/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formkey = GlobalKey();
  late String _email = '';
  late String _password = '';

  Future<void> _submit() async {
    final form = _formkey.currentState;
    if (form != null && form.validate()) {
      form.save();

      final token = await ApiService.signIn(_email, _password);

      if (token != null) {
        // Manejar el éxito del inicio de sesión aquí
        print('Token recibido: $token');
      } else {
        // Manejar el error del inicio de sesión aquí
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          InputText(
            hint: 'Correo electrónico',
            label: 'Email Address',
            keyboard: TextInputType.emailAddress,
            icono: Icon(Icons.verified_user), // Agrega la coma
            onChanged: (data) {
              setState(() {
                _email = data;
              });
            },
            validator: (data) {
              if (!data.contains('@')) { // Elimina la comprobación de nulabilidad
                return "Invalid email";
              }
              return '';
            },
          ),
          Divider(
            height: 15.0,
          ),
          InputText(
            hint: 'Contraseña',
            label: 'Password',
            obsecure: true,
            icono: Icon(Icons.lock_outline), // Agrega la coma
            onChanged: (data) {
              setState(() {
                _password = data;
              });
            },
            validator: (data) {
              if (data == null || data.trim().isEmpty) { // Maneja el caso de que data sea nulo
                return "Invalid password";
              }
              return '';
            },
          ),
          Divider(
            height: 15.0,
          ),
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
              color: Colors.pink,
              onPressed: _submit, 
              child: Text(
                'Sing In',
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
