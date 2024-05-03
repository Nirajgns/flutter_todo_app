import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewNotePage extends StatefulWidget {
  const AddNewNotePage({super.key});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  FocusNode noteFocus = FocusNode();
  FocusNode titleFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
        centerTitle: true,
        title: const Text("Add new note..."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                if (value != "") {
                  noteFocus.requestFocus();
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
                focusNode: noteFocus,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text("Note"),
                    hintText: "Enter your note here..."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
