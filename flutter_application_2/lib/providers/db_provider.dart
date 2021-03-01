import 'dart:io';

import 'package:flutter_application_2/models/person_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    final path = join(appDir.path, 'personas.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Persons(
          id  INTEGER PRIMARY KEY,
          nombre TEXT,
          cedula TEXT,
          apellido TEXT,
          discapacidad TEXT,
          nacimiento TEXT
        )      
      ''');
    });
  }
  ///Métodos CRUD / L para SQLite
  ///
  Future<int> create(Person newTravel) async {
    final db = await database;
    final newId = await db.insert('Persons', newTravel.toJson());
    return newId;
  }

  Future<dynamic> list() async {
    final db = await database;
    final result = await db.query('Persons');
    return result.isNotEmpty
        ? result.map((t) => Person.fromJson(t)).toList()
        : [];
  }

  Future<int> createSQL(Person newTravel) async {
    final id = newTravel.id;
    final nombre = newTravel.nombre;
    final cedula = newTravel.cedula;
    final apellido = newTravel.apellido;
    final discapacidad = newTravel.discapacidad;
    final nacimiento  = newTravel.nacimiento;
    final db = await database;
    final newId = await db.rawInsert('''
      INSERT INTO Persons(id, nombre, cedula, apellido, discapacidad, nacimiento)
      VALUES ($id, '$nombre', '$cedula', '$apellido', '$discapacidad', '$nacimiento')
    ''');
    return newId;
  }
}