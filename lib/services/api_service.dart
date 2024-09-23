import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noteapp/models/node_model.dart';

class ApiService {
  static const String _baseUrl = "http://localhost:3000/api/notes/";

  static Future<void> addNote(Note note) async {
    var response = await http.post(Uri.parse(_baseUrl), body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
    print(note.toMap());
  }

  static Future<void> updateNote(Note note) async {
    try {
      var response = await http.put(
        Uri.parse('$_baseUrl/${note.id}'),
        headers: {
          'Content-Type': 'application/json', // Send as JSON
          'Accept': 'application/json', // Expect JSON in response
        },
        body: jsonEncode(note.toMap()), // Convert the note to JSON
      );

      // Check the status code before parsing
      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body); // Parse JSON response
        (decoded.toString());
      } else {
        return;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> deleteNote(Note note) async {
    try {
      var response = await http.delete(
        Uri.parse('$_baseUrl/${note.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Check the status code and handle the response
      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);
        print('Note deleted successfully: $decoded');
      } else {
        print(response.body);
        print(note.id);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<List<Note>> getAllNotes() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Accept': 'application/json', // Expect JSON response
        },
      );

      // Check if the response status is OK (200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> decoded = jsonDecode(response.body);

        // Map the JSON list to a List of Note objects
        return decoded.map((note) => Note.fromMap(note)).toList();
      } else {
        return []; // Return an empty list on error
      }
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list on error
    }
  }
}
