import 'package:leitor_codigo_de_barras/models/Item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 4;
  static const String _dbName = "Items.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE ITEM(codigo VARCHAR(80) PRIMARY KEY NOT NULL, descricao VARCHAR(80) NOT NULL, quantidade VARCHAR(80) NOT NULL, valorUnitario VARCHAR(80))"),
        version: _version);
  }

  static Future<int> addItem(Item item) async {
    final db = await _getDB();
    return await db.insert("ITEM", item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateItem(Item item) async {
    final db = await _getDB();
    return db.update("ITEM", item.toJson(),
        where: 'codigo = ?',
        whereArgs: [item.codigo],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteItem(Item item) async {
    final db = await _getDB();
    return db.delete("ITEM", where: 'codigo = ?', whereArgs: [item.codigo]);
  }

  static Future<List<Item>?> getItem(codigo) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM ITEM WHERE CODIGO LIKE ($codigo)');
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Item.fromJson(maps[index]));
  }

  static Future<List<Item>?> getAllItem() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("ITEM");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Item.fromJson(maps[index]));
  }
}
