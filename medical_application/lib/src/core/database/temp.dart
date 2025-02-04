import 'package:sqflite/sqflite.dart';

import '../../features/features.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('medical.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Your table creation statements remain the same
  }

  // Example of using a transaction for a batch operation
  Future<void> addDoctorWithTasks(Doctor doctor, List<Task> tasks) async {
    final db = await database;
    await db.transaction((txn) async {
      // Insert doctor
      final doctorId = await txn.insert(
        'doctor',
        doctor.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insert tasks
      for (var task in tasks) {
        await txn.insert(
          'task',
          task.copyWith(doctorId: doctorId).toMap(), // Ensure task is associated with the inserted doctor
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  join(String dbPath, String filePath) {}

}