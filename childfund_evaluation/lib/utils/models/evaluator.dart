class Evaluator {
  int userId;
  String rol;
  String mail;
  String name;
  String lastname;
  String identificacion;
  String phone;
  String position;
  int officerId;

  Evaluator(
      {required this.userId,
      required this.rol,
      required this.mail,
      required this.name,
      required this.lastname,
      required this.identificacion,
      required this.phone,
      required this.position,
      required this.officerId});

  Evaluator.vacio()
      : name = '',
        lastname = '',
        rol = '',
        mail = '',
        identificacion = '',
        phone = '',
        position = '',
        userId = 0,
        officerId = 0;

  String getData() {
    return 'Usuario {name: $name $lastname, identificacion: $identificacion, rol: $rol, mail: $mail, officer_id: $officerId}';
  }
}
