import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hint;
  final Icon icono;
  final TextInputType keyboard;
  final bool obsecure;
  final void Function(String) onChanged;
  final String Function(String) validator; // Cambiado a 'String Function(String)'

  const InputText({
    Key? key,
    this.label = '',
    this.hint = '',
    required this.icono,
    this.keyboard = TextInputType.text,
    this.obsecure = false,
    required this.onChanged,
    required this.validator, // Cambiado a 'required'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: keyboard,
        obscureText: obsecure,
        onChanged: onChanged,
        validator: (String? data) => validator(data ?? ''), // Adaptado para cumplir con 'String? Function(String?)?'
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.blueGrey,
            fontSize: 25.0,
          ),
          suffixIcon: icono,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
