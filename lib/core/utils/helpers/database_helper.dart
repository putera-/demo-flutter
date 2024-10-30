import 'package:path/path.dart';
import 'package:pgnpartner_mobile/data/models/form_data/job_construction_form_data.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'db_pgn.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE job_construction_form_data (
            idSubTask INTEGER PRIMARY KEY,
            nama_task TEXT,
            payload TEXT
          )
        ''');
      },
    );
  }

  Future<JobConstructionFormData?> getFormData(int idSubTask) async {
    final db = await database;
    final result = await db.query(
      'job_construction_form_data',
      where: 'idSubTask = ?',
      whereArgs: [idSubTask],
    );

    if (result.isNotEmpty) {
      return JobConstructionFormData(
        idSubTask: result.first['idSubTask'] as int,
        namaTask: result.first['nama_task'] as String,
        payload: result.first['payload'] as String,
      );
    }
    return null;
  }

  Future<void> insertFormData(JobConstructionFormData data) async {
    final db = await database;
    await db.insert(
      'job_construction_form_data',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> isTaskExist(int idSubTask) async {
    final db = await database;
    final result = await db.query(
      'job_construction_form_data',
      where: 'idSubTask = ?',
      whereArgs: [idSubTask],
    );
    return result.isNotEmpty;
  }

  Future<void> updateFormData(JobConstructionFormData data) async {
    final db = await database;
    await db.update(
      'job_construction_form_data',
      data.toMap(),
      where: 'idSubTask = ?',
      whereArgs: [data.idSubTask],
    );
  }

  Future<void> deleteFormDataByIdSubTask(int idSubTask) async {
    final db = await database;
    await db.delete(
      'job_construction_form_data',
      where: 'idSubTask = ?',
      whereArgs: [idSubTask],
    );
  }
}