import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/providers/notes_provoder.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  const AddNewNotePage({super.key});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  FocusNode contentFocus = FocusNode();
  FocusNode titleFocus = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void addNewNote() {
    Note newNote = Note(
      id: const Uuid().v1(),
      userid: "niraj",
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now(),
    );
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
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
              icon: const Icon(Icons.check))
        ],
        centerTitle: true,
        title: const Text("Add new note..."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (value) {
                if (value != "") {
                  contentFocus.requestFocus();
                } else {
                  titleFocus.requestFocus();
                }
              },
              autofocus: true,
              focusNode: titleFocus,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  label: Text("Title"),
                  hintText: "Enter your title here..."),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                maxLines: null,
                controller: contentController,
                focusNode: contentFocus,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text("Note Content"),
                    hintText: "Enter your note content here..."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
