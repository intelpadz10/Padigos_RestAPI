import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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

    super.initState();
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
                  child:
                      const Text('Save', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (isEditing) {
                      //update note in api
                    } else {
                      //create note in api
                    }
                    Navigator.of(context).pop();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
