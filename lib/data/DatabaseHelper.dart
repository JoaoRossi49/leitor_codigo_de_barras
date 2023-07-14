import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/Item.dart';

Future<Database> openDB() async {
  // Caminho do banco de dados
  String path = join(await getDatabasesPath(), 'database.db');

  // Criação e abertura do banco de dados
  return await openDatabase(
    path,
    version: 2,
    onCreate: (db, version) {
      // Criação da tabela
      return db.execute(
        'CREATE TABLE items (id INTEGER PRIMARY KEY, codigo TEXT)',
      );
    },
  );
}
