import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelperClass {
  Database? _database;

  Future<void> initDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(appDirectory.path, "Library_catalog.db");
    _database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS BookDetails (
        BookId INTEGER PRIMARY KEY AUTOINCREMENT,
        BookName TEXT,
        BookAuthor TEXT,
        BookGenre TEXT,
        BookAvailableCopies INTEGER
      )
    ''');
    });
  }

  Future<List<Map<String, Object?>>> getDataFromLibrary() async {
    if (_database == null) {
      await initDatabase();
    }
    var data = await _database!.rawQuery("select * from BookDetails");
    return data;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS BookDetails (
        BookId INTEGER PRIMARY KEY AUTOINCREMENT,
        BookName TEXT,
        BookAuthor TEXT,
        BookGenre TEXT,
        BookAvailableCopies INTEGER
      )
    ''');
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, "Library_catalog.db");
    if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
      ByteData data =
          await rootBundle.load(join('assets/database', 'Library_catalog.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<void> insertBook({
    required String bookName,
    required String bookAuthor,
    required String bookGenre,
    required int bookAvailableCopies,
  }) async {
    try {
      if (_database == null) {
        await initDatabase();
      }
      Map<String, dynamic> map = {
        "BookName": bookName,
        "BookAuthor": bookAuthor,
        "BookGenre": bookGenre,
        "BookAvailableCopies": bookAvailableCopies,
      };
      await _database?.insert("BookDetails", map);
    } catch (e) {
      print("Error inserting book: $e");
    }
  }

  Future<int?> updateBook({
    required int bookId,
    required String bookName,
    required String bookAuthor,
    required String bookGenre,
    required int bookAvailableCopies,
  }) async {
    try {
      if (_database == null) {
        await initDatabase();
      }
      Map<String, dynamic> map = {
        "BookName": bookName,
        "BookAuthor": bookAuthor,
        "BookGenre": bookGenre,
        "BookAvailableCopies": bookAvailableCopies,
      };
      var data = await _database
          ?.update("BookDetails", map, where: "BookId=?", whereArgs: [bookId]);
      return data;
    } catch (e) {
      print("Error updating book: $e");
      return 0;
    }
  }

  Future<int?> deleteBook(int id) async {
    try {
      if (_database == null) {
        await initDatabase();
      }
      var data = await _database
          ?.delete("BookDetails", where: "BookId=?", whereArgs: [id]);
      return data;
    } catch (e) {
      print("Error deleting book: $e");
      return 0;
    }
  }

  Future<void> closeDatabase() async {
    await _database?.close();
  }
}
