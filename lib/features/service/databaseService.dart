import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/workoutModel.dart';

class DatabaseService {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'workout.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE workouts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          value INTEGER,
          isDone INTEGER,
          date TEXT
        )
      ''');
    });
  }

  Future<void> insertWorkout(Workout workout) async {
    final dbClient = await db;
    await dbClient.insert('workouts', workout.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Workout>> getAllWorkouts() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('workouts');
    return List.generate(maps.length, (i) {
      return Workout.fromMap(maps[i]);
    });
  }

  Future<void> updateWorkout(Workout workout) async {
    final dbClient = await db;
    await dbClient.update('workouts', workout.toMap(),
        where: 'id = ?', whereArgs: [workout.id]);
  }
}
