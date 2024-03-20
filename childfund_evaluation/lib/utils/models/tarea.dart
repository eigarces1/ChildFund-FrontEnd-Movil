class Tarea {
  String indicador;
  String? materiales;
  String instrucciones;
  String imagen;
  String? response;
  bool? accomplished; // New property to track if the step is accomplished

  Tarea({
    required this.indicador,
    this.materiales,
    required this.instrucciones,
    required this.imagen,
    this.response,
    this.accomplished, //Default value is false
  });
}
