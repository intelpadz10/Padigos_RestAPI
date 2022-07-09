import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:padigos_restapi/models/note_for_listing.dart';
import 'package:padigos_restapi/services/notes_service.dart';
import 'package:padigos_restapi/views/note_delete.dart';
import 'package:padigos_restapi/views/note_modify.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.instance<NotesService>();

  List<NoteForListing> notes = [];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    notes = service.getNotesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Note List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NoteModify()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: Color.fromARGB(255, 174, 170, 155)),
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(notes[index].noteID),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {},
            confirmDismiss: (direction) async {
              final result = await showDialog(
                  context: context, builder: (context) => const NoteDelete());
              return result;
            },
            background: Container(
                color: Colors.red,
                padding: const EdgeInsets.only(left: 16),
                child: const Align(
                    child: Icon(Icons.delete, color: Colors.white))),
            child: ListTile(
                title: Text(notes[index].noteTitle,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 100, 10, 255))),
                subtitle: Text(
                    'Last edited on ${formatDateTime(notes[index].lastEditDateTime)}'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          NoteModify(noteID: notes[index].noteID)));
                }),
          );
        },
        itemCount: notes.length,
      ),
    );
  }
}
