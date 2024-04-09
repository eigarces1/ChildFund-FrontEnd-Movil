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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastname': lastname,
      'identificacion': identificacion,
      'rol': rol,
      'mail': mail,
      'userId': userId,
      'officerId': officerId,
      'phone': phone,
      'position': position,
    };
  }

  factory Evaluator.fromJson(Map<String, dynamic> json) {
    return Evaluator(
        userId: json['userId'],
        rol: json['rol'],
        mail: json['mail'],
        name: json['name'],
        lastname: json['lastname'],
        identificacion: json['identificacion'],
        phone: json['phone'],
        position: json['position'],
        officerId: json['officerId']);
  }
}
