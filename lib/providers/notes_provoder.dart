import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/services/api_services.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;

  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
    ApiService.updateNote(note);
  }

  void deleteNote(Note note) {
    notes.removeWhere((element) => element.id == note.id);
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNotes("niraj");
    isLoading = false;
    notifyListeners();
  }
}
