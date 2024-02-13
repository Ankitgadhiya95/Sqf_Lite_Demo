import 'package:sqflite/sqflite.dart';
import 'package:sqflitedemo/todo_model.dart';

class DataBaseRepo {
  /// Create Database and OPNE Database

  static Future<Database> db() async {
    return openDatabase('dbtech.db', version: 1,
        onCreate: (database, int version) async {
      await _createDB(database, version);
    });
  }

  /// Create Database Table

  static Future _createDB(Database db, int version) async {
    await db.execute('''
    create table todoTable(
    id integer primary key autoincrement,
    title text not null,
    description text not null)''');
  }

  /// Insert Record

  static Future createItem(String title, String description) async {
    final db = await DataBaseRepo.db();
    final data = {'title': title, 'description': description};
    final id = await db.insert('todoTable', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
    return id;
  }

  /// Get data from database

  static Future getItems() async {
    List<ToDoModel> todoList = [];
    final db = await DataBaseRepo.db();
    var data = await db.query('todoTable', orderBy: 'id');
    for (var e in data) {
      todoList.add(ToDoModel.fromJson(e));
    }
    return todoList;
  }

  ///Update Item

  static Future updateItem(int id, String title, String description) async {
    final db = await DataBaseRepo.db();
    final data = {'title': title, 'description': description};
    final result =
        await db.update('todoTable', data, where: 'id=?', whereArgs: [id]);
    return result;
  }

  ///Delete Item

  static Future deleteItem(int id) async {
    final db = await DataBaseRepo.db();
    try {
      await db.delete('todoTable', where: "id=?", whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }

  ///Get Items by id

  static Future getItemsbyId(int id) async {
    final db = await DataBaseRepo.db();
    List<ToDoModel> todoList = [];
    var data = await db.query('todoTable', whereArgs: [id], where: "id=?");
    for (var e in data) {
      todoList.add(ToDoModel.fromJson(e));
    }
    return todoList;
  }
}
