import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final String url;
  final double size;

  const IconContainer({Key? key, required this.url, required this.size})
      : assert(url != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: Image.asset(
        this.url,
        fit: BoxFit.contain, // Ajusta la imagen al contenedor sin cortarla
      ),
    );
  }
}
