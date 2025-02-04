import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:medical_application/src/src.dart';

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
    await db.execute('''
      CREATE TABLE if not exists user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        gender TEXT NOT NULL,
        age INTEGER NOT NULL,
        photo TEXT,
        phone INTEGER NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        isDoctor INTEGER DEFAULT 0
      );
    ''');
    await db.execute('''
      CREATE TABLE if not exists doctor(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        gender TEXT NOT NULL,
        age INTEGER NOT NULL,
        photo TEXT,
        phone TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        description TEXT,
        specialist TEXT NOT NULL
      );
    ''');
    await db.execute('''
      CREATE TABLE advice(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        doctorId INTEGER,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (doctorId) REFERENCES doctor(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE task(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        doctorId INTEGER,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        tag TEXT NOT NULL,
        taskDone INTEGER DEFAULT 0,
        FOREIGN KEY (doctorId) REFERENCES doctor(id)
      );
    ''');
  }

  Future<User?> addUser(User user) async {
    final db = await database;
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return await loginUser(user.email, user.password);
  }

  Future<Doctor?> addDoctor(Doctor doctor) async {
    final db = await database; // الحصول على مثيل القاعدة
    await db.insert(
      'doctor',
      doctor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return await loginDoctor(doctor.email, doctor.password);
  }

  Future<void> addTask(Task task) async {
    final db = await database;
    await db.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> addAdvice(Advice advice) async {
    final db = await database;
    await db.insert(
      'advice',
      advice.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Doctor?> loginDoctor(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'doctor',
      where: 'email = ? and password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      print(maps.toString());
      return Doctor.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> loginUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'email = ? and password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<Doctor> updateDoctor(Doctor doctor) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'doctor',
      where: 'email = ? and password = ?',
      whereArgs: [doctor.email, doctor.password],
    );
    var id = Doctor.fromMap(maps.first).id;
    await db.update(
      'doctor',
      doctor.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );

    final List<Map<String, dynamic>> newDoctors = await db.query(
      'doctor',
      where: 'id = ?',
      whereArgs: [id],
    );

    return Doctor.fromMap(newDoctors.first);
  }

  Future<User> updateUser(User user) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'email = ? and password = ?',
      whereArgs: [user.email, user.password],
    );
    var id = Doctor.fromMap(maps.first).id;

    await db.update(
      'user',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    final List<Map<String, dynamic>> newUser = await db.query(
      'user',
      where: 'id = ?',
      whereArgs: [id],
    );
    return User.fromMap(newUser.first);
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
     db.update(
      'task',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(Task task) async {
    final db = await database;
    await db.delete(
      'task',
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<List<Doctor>> getDoctors() async {
    final db = await database;
    final List<Map<String, dynamic>> doctorMaps = await db.query('doctor');
    return List.generate(doctorMaps.length, (i) {
      return Doctor(
        id: doctorMaps[i]['id'],
        name: doctorMaps[i]['name'],
        gender: doctorMaps[i]['gender'],
        age: doctorMaps[i]['age'],
        photo: doctorMaps[i]['photo'],
        phone: doctorMaps[i]['phone'].toString(),
        email: doctorMaps[i]['email'],
        password: doctorMaps[i]['password'],
        description: doctorMaps[i]['description'],
        specialist: doctorMaps[i]['specialist'],
      );
    });
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> userMaps =
        await db.query('user'); // جلب جميع السجلات من جدول doctors
    return List.generate(userMaps.length, (i) {
      return User(
        id: userMaps[i]['id'],
        name: userMaps[i]['name'],
        gender: userMaps[i]['gender'],
        age: userMaps[i]['age'],
        photo: userMaps[i]['photo'],
        phone: userMaps[i]['phone'].toString(),
        email: userMaps[i]['email'],
        password: userMaps[i]['password'],
      );
    });
  }

  Future<List<Advice>> getAdvices() async {
    final db = await database;
    final List<Map<String, dynamic>> adviceMaps =
        await db.query('advice'); // جلب جميع السجلات من جدول doctors
    return List.generate(adviceMaps.length, (i) {
      return Advice(
        id: adviceMaps[i]['id'],
        title: adviceMaps[i]['title'],
        doctorId: adviceMaps[i]['doctorId'],
        description: adviceMaps[i]['description'],
        date: adviceMaps[i]['date'],
      );
    });
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> taskMaps = await db.query(
      'task',
      where: 'taskDone = ?',
      whereArgs: [1],
    );
    return List.generate(taskMaps.length, (i) {
      return Task(
        id: taskMaps[i]['id'],
        title: taskMaps[i]['title'],
        doctorId: taskMaps[i]['doctorId'],
        description: taskMaps[i]['description'],
        date: taskMaps[i]['date'],
        time: taskMaps[i]['time'],
        tag: taskMaps[i]['tag'],
      );
    });
  }

  Future<List<Task>> getOrders() async {
    final db = await database;
    final List<Map<String, dynamic>> taskMaps = await db.query(
      'task',
      where: 'taskDone = ?',
      whereArgs: [0],
    ); // جلب جميع السجلات من جدول doctors
    return List.generate(taskMaps.length, (i) {
      return Task(
        id: taskMaps[i]['id'],
        title: taskMaps[i]['title'],
        doctorId: taskMaps[i]['doctorId'],
        description: taskMaps[i]['description'],
        date: taskMaps[i]['date'],
        time: taskMaps[i]['time'],
        tag: taskMaps[i]['tag'],
      );
    });
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
