import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_training/screens/notes/models/note.dart';
import 'package:flutter_training/screens/notes/sqflite/db_helper.dart';
import 'package:uuid/uuid.dart';

class NoteProvider with ChangeNotifier {
  Uint8List? bytes;

  DBHelper dbHelper = DBHelper();

  List<Note> _notes = [];

  List<Note> get notes {
    return [..._notes];
  }

  //database
  Future insertDatabase(
    String title,
    String content,
    String color,
  ) async {
    final newNote = Note(
      id: const Uuid().v1().split('-').toList()[0].toString(),
      title: title,
      content: content,
      color: color,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
    );
    _notes.add(newNote);

    await DBHelper.insert('Notes', {
      'id': newNote.id,
      'title': newNote.title,
      'content': newNote.content,
      'createdAt': newNote.createdAt,
      'updatedAt': newNote.updatedAt,
      'color': newNote.color,
    });

    notifyListeners();
  }

  // show items
  Future<void> getNotes() async {
    final dataList = await DBHelper.selectNotes();
    _notes = dataList
        .map((item) => Note(
              id: item['id'],
              title: item['title'],
              content: item['content'],
              createdAt: item['createdAt'],
              updatedAt: item['updatedAt'],
              color: item['color'],
            ))
        .toList();
    notifyListeners();
  }

  Future<void> deleteProductById(String pickId) async {
    await DBHelper.deleteById('Notes', 'id', pickId);
    notifyListeners();
  }

  Future<Note> selectNoteById(String pickId) async {
    final response = await DBHelper.selectNoteById(pickId);
    return Note.fromMap(response[0]);
  }

  Future<List<Note>> searchNoteByTitle(String title) async {
    final response = await DBHelper.searchNoteByTitle(title);
    return response;
  }

  Future<void> updateProductNameById(
      String id, String title, String content, String updatedAt) async {
    final db = await DBHelper.database();
    await db.update(
      'Notes',
      {'title': title, 'content': content, 'updatedAt': updatedAt},
      where: "id = ?",
      whereArgs: [id],
    );
    // for (var element in _notes) {
    //   if (element.id == id) {
    //     element.title = title;
    //     element.content = content;
    //   }
    // }
    getNotes();
    notifyListeners();
  }

  Future<void> deteleTable() async {
    await DBHelper.deleteTable('Notes');
    notifyListeners();
  }
}
