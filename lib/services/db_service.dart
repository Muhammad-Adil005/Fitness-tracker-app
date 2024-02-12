import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/workout.dart';

class DBService {
  static Database? _db;

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'fitness_tracker.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE workouts(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          type TEXT, 
          date TEXT, 
          duration INTEGER
        )
      ''');
      // Add more tables for goals or other data as needed
    });
  }

  static Future<void> insertWorkout(Workout workout) async {
    final db = await getDatabase();
    await db.insert('workouts', workout.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Workout>> getWorkouts() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('workouts');

    return List.generate(maps.length, (i) {
      return Workout.fromMap(maps[i]);
    });
  }

// Add methods for updating and deleting workouts, and for managing goals
}
