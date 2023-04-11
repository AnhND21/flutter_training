// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'dart:convert';
import 'package:flutter_training/screens/notes/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // DBHelper._();

  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'db_helper.db'),
      onCreate: (db, version) async {
        await db
            .execute('CREATE TABLE IF NOT EXISTS Notes (id TEXT PRIMARY KEY ,'
                ' title TEXT,'
                ' content TEXT,'
                ' color TEXT,'
                ' createdAt TEXT,'
                ' updatedAt TEXT)');
      },
      version: 1,
    );
  }

  //delete table
  static Future deleteTable(String table) async {
    final db = await DBHelper.database();
    return db.rawDelete('DROP TABLE IF EXISTS Notes');
  }

  // insert data
  static Future insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    return db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //show all items
  static Future<List<Map<String, dynamic>>> selectAll(
    String table,
    order,
  ) async {
    final db = await DBHelper.database();
    return db.query(
      table,
      orderBy: order,
    );
  }

  //delete value by id
  static Future<void> deleteById(
    String table,
    String columnId,
    String id,
  ) async {
    final db = await DBHelper.database();
    await db.delete(
      table,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  //show items by id
  static Future selectNoteById(String id) async {
    final db = await DBHelper.database();
    return await db.query(
      'Notes',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //show items by title
  static Future searchNoteByTitle(String title) async {
    final db = await DBHelper.database();
    List<Map<String, Object?>> result = await db.query(
      'Notes',
      where: "title LIKE ?",
      whereArgs: ['%$title%'],
    );
    List<Note> notes = [];
    if (result.isNotEmpty) {
      for (var element in result) {
        notes.add(Note(
            id: element['id'].toString(),
            title: element['title'].toString(),
            content: element['content'].toString(),
            createdAt: element['createdAt'].toString(),
            updatedAt: element['updatedAt'].toString(),
            color: element['color'].toString()));
      }
    }
    return notes;
  }

  //show items
  static Future<List<Map<String, dynamic>>> selectNotes() async {
    final db = await DBHelper.database();
    var select = await db.query('Notes');
    return select;
  }
}
