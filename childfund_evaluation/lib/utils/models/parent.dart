class Parent {
  int userId;
  int parentId;
  String rol;
  String mail;
  String name;
  String lastname;
  String identificacion;
  String phone;
  String position;

  Parent({
    required this.userId,
    required this.parentId,
    required this.rol,
    required this.mail,
    required this.name,
    required this.lastname,
    required this.identificacion,
    required this.phone,
    required this.position,
  });

  Parent.vacio()
      : name = '',
        lastname = '',
        rol = '',
        mail = '',
        identificacion = '',
        phone = '',
        position = '',
        userId = 0,
        parentId = 0;

  String getData() {
    return 'Usuario {name: $name $lastname, identificacion: $identificacion, rol: $rol, mail: $mail}';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastname': lastname,
      'identificacion': identificacion,
      'rol': rol,
      'mail': mail,
      'userId': userId,
      'parentId': parentId,
      'phone': phone,
      'position': position,
    };
  }

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
        userId: json['userId'],
        parentId: json['parentId'],
        rol: json['rol'],
        mail: json['mail'],
        name: json['name'],
        lastname: json['lastname'],
        identificacion: json['identificacion'],
        phone: json['phone'],
        position: json['position']);
  }
}
