class Tarea {
  String indicador;
  String? materiales;
  String instrucciones;
  String imagen;
  bool? accomplished; // New property to track if the step is accomplished

  Tarea({
    required this.indicador,
    this.materiales,
    required this.instrucciones,
    required this.imagen,
    this.accomplished, //Default value is false
  });
}
