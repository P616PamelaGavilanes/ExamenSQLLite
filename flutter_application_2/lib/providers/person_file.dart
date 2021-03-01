import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/person_model.dart';
import 'package:flutter_application_2/providers/db_provider.dart';


class PersonProvider extends ChangeNotifier {
  List<Person> persons = [];

  Future<Person> addPerson(String nombre, String cedula,String apellido,String discapacidad,String nacimiento) async {
    Person person = Person(nombre: nombre, cedula: cedula,apellido:apellido,discapacidad:discapacidad,nacimiento: nacimiento);
    //person.nacimiento = DateTime.now().toIso8601String();
    final id = await DBProvider.db.create(person);
    person.id = id;
    persons.add(person);
    notifyListeners();
    return person;
  }
  loadPersons() async {
    final travelsQuery = await DBProvider.db.list();
    this.persons = [...travelsQuery];
    notifyListeners();
  }
}