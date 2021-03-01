import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
  Person({
    this.id,
    this.nombre,
    this.cedula,
    this.apellido,
    this.discapacidad,
    this.nacimiento,
  });

  int id;
  String nombre;
  String cedula;
  String apellido;
  String nacimiento;
  String discapacidad;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        nombre: json["name"],
        cedula: json["cedula"],
         apellido: json["apellido"],
         discapacidad:json["discapacidad"],
         nacimiento:json["nacimiento"],
         
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "cedula": cedula,
        "apellido":  apellido,
        "discapacidad":discapacidad,
        "nacimiento": nacimiento,
      };
}


