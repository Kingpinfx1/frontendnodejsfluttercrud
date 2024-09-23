import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/node_model.dart';
import '../providers/notes_provider.dart';

class EditNote extends StatefulWidget {
  final Note note;
  const EditNote({
    super.key,
    required this.note,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title!;
    contentController.text = widget.note.content!;
  }

  void updateNote() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title cannot be empty"),
        ),
      );
      return;
    }

    widget.note.title = titleController.text;
    widget.note.content = contentController.text;

    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Note updated successfully"),
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
              Provider.of<NotesProvider>(context, listen: false)
                  .deleteNote(widget.note);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Note deleted successfully"),
                ),
              );
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              updateNote();
            },
            icon: const Icon(
              Icons.check_circle,
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
