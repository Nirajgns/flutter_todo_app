import 'package:flutter/material.dart';
import 'package:todo_app/models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  void addNote(Note note) {
    notes.add(note);
  }

  void deleteNote(Note note) {}

  void updateNote() {}
}
