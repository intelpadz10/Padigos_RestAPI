import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:padigos_restapi/models/note_insert.dart';
import 'package:padigos_restapi/models/note_update.dart';
import 'package:padigos_restapi/models/single_note.dart';
import 'package:padigos_restapi/services/notes_service.dart';

class NoteModify extends StatefulWidget {
  const NoteModify({Key? key, this.noteID = " "}) : super(key: key);

  final String noteID;

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  NotesService get service => GetIt.instance<NotesService>();
  bool get isEditing => widget.noteID != " ";

  late String errorMessage;
  late SingleNote note;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  // ignore: unused_field
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      service.getSingleNote(widget.noteID).then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage;
        }
        note = response.data!;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Create Note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Note Title',
              ),
            ),
            Container(height: 8),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: ElevatedButton(
                  child: const Text('Save Note',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (isEditing) {
                      setState(() {
                        _isLoading = true;
                      });
                      final note = UpdateNote(
                        noteTitle: _titleController.text,
                        noteContent: _contentController.text,
                      );
                      final result =
                          await service.updateNote(widget.noteID, note);

                      setState(() {
                        _isLoading = false;
                      });
                      const title = 'Done';
                      final text =
                          result.error ? (result.errorMessage) : 'note edited';

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok')),
                          ],
                        ),
                      ).then((data) {
                        if (result.data!) {
                          Navigator.of(context).pop();
                        }
                      });
                    } else {
                      setState(() {
                        _isLoading = true;
                      });
                      final note = InsertNote(
                        noteTitle: _titleController.text,
                        noteContent: _contentController.text,
                      );
                      final result = await service.createNote(note);

                      setState(() {
                        _isLoading = false;
                      });
                      const title = 'Done';
                      final text =
                          result.error ? (result.errorMessage) : 'note created';

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok')),
                          ],
                        ),
                      ).then((data) {
                        if (result.data!) {
                          Navigator.of(context).pop();
                        }
                      });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
