import 'package:flutter/material.dart';
import 'package:noteapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../models/node_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  void addNewNote() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title cannot be empty"),
        ),
      );
      return;
    }

    Note newNote = Note(
      id: '',
      title: titleController.text,
      content: contentController.text,
      createdAt: DateTime.now(),
    );

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Note added successfully"),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              addNewNote();
            },
            icon: const Icon(
              Icons.note_add,
              color: Colors.green,
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "title",
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              autofocus: true,
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "enter note",
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
