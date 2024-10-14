import 'package:lab07/work.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'workers.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE workers(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, department TEXT)',
    );
  }

  Future<void> insertWorker(Manager manager) async {
    final db = await database;
    await db.insert('workers', {
      'name': manager.name,
      'age': manager.age,
      'department': manager.department,
    });
  }

  Future<List<Map<String, dynamic>>> getWorkers() async {
    final db = await database;
    return db.query('workers');
  }

  Future<Map<String, dynamic>> getWorkerById(int id) async {
    final db = await database;
    return (await db.query('workers', where: 'id = ?', whereArgs: [id]))[0];
  }

  Future<void> updateWorker(Manager manager, int id) async {
    final db = await database;
    await db.update(
      'workers',
      {
        'name': manager.name,
        'age': manager.age,
        'department': manager.department,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteWorker(int id) async {
    final db = await database;
    await db.delete('workers', where: 'id = ?', whereArgs: [id]);
  }
}
