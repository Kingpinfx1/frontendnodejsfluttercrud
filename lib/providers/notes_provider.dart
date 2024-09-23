import 'package:flutter/material.dart';
import 'package:noteapp/models/node_model.dart';
import 'package:noteapp/services/api_service.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> notes = [];
  bool isLoading = true;

  NotesProvider() {
    fetchNotes();
  }
  void addNote(Note note) {
    notes.add(note);
    ApiService.addNote(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    ApiService.updateNote(note);
    notifyListeners();
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    ApiService.deleteNote(note);
    notifyListeners();
  }

  void fetchNotes() async {
    List<Note> fetchedNotes = await ApiService.getAllNotes();
    notes = fetchedNotes.reversed.toList();
    isLoading = false;
    notifyListeners();
  }
}
