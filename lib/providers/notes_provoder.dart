import 'package:flutter/material.dart';
import 'package:todo_app/models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
  }

  void deleteNote(Note note) {
    notes.removeWhere((element) => element.id == note.id);
    notifyListeners();
  }
}
