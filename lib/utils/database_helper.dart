import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/movie.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'movie_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      )
    ''');
  }

  Future<int> insertFavorite(Movie movie) async {
    Database db = await instance.database;
    return await db.insert('favorites', movie.toMap());
  }

  Future<List<Movie>> queryAllFavorites() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return Movie(
        id: maps[i]['id'],
        title: maps[i]['title'],
        overview: maps[i]['overview'],
        posterPath: maps[i]['posterPath'],
      );
    });
  }

  Future<int> deleteFavorite(int id) async {
    Database db = await instance.database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}
