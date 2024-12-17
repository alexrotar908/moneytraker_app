class User {
  int? id; // Campo autoincremental, puede ser null al registrar un nuevo usuario
  String idType; // Tipo de documento (DNI, Pasaporte, etc.)
  String idNumber; // Número de documento
  String firstName; // Nombre del usuario
  String lastName; // Apellido del usuario
  String username; // Nombre de usuario único
  String pin; // PIN para autenticación

  // Constructor
  User({
    this.id,
    required this.idType,
    required this.idNumber,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.pin,
  });

  // Convierte un objeto User en un Map para guardarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_type': idType,
      'id_number': idNumber,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'pin': pin,
    };
  }

  // Crea un objeto User a partir de un Map (ej. al recuperar de la base de datos)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      idType: map['id_type'],
      idNumber: map['id_number'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      username: map['username'],
      pin: map['pin'],
    );
  }
}
