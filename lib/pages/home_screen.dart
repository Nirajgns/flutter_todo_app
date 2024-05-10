import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/pages/add_new_note.dart';
import 'package:todo_app/providers/notes_provoder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: (notesProvider.isLoading == false)
          ? SafeArea(
              child: (notesProvider.notes.isNotEmpty)
                  ? ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintText: "Search your notes...",
                                labelText: "Search"),
                          ),
                        ),
                        (notesProvider.getFilteredNotes(searchQuery).length > 0)
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: notesProvider
                                    .getFilteredNotes(searchQuery)
                                    .length,
                                itemBuilder: (context, index) {
                                  Note currentNote = notesProvider
                                      .getFilteredNotes(searchQuery)[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddNewNotePage(
                                            isUpdate: true,
                                            note: currentNote,
                                          ),
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      //deletes note
                                      notesProvider.deleteNote(currentNote);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Colors.grey,
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currentNote.title!,
                                            style:
                                                const TextStyle(fontSize: 20),
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
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(50),
                                  child: Text(
                                    "No notes found...",
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        "You haven't created any notes yet...",
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    "We are loading your notes...",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const AddNewNotePage(
                  isUpdate: false,
                ),
              ),
            );
          },
          label: const Text("Add Note")),
    );
  }
}
