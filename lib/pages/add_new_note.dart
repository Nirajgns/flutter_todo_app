import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/providers/notes_provoder.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({super.key, required this.isUpdate, this.note});

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

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;

    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                widget.isUpdate ? updateNote() : addNewNote();
              },
              icon: const Icon(Icons.check))
        ],
        centerTitle: true,
        title: Text(widget.isUpdate ? "Update note" : "Add note"),
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
              autofocus: widget.isUpdate ? false : true,
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
