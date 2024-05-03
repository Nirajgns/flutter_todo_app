import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/pages/add_new_note.dart';
import 'package:todo_app/providers/notes_provoder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: notesProvider.notes.length,
          itemBuilder: (context, index) {
            Note currentNote = notesProvider.notes[index];

            return Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentNote.title!,
                    style: const TextStyle(fontSize: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentNote.content!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const AddNewNotePage(),
              ),
            );
          },
          label: const Text("Add Note")),
    );
  }
}
