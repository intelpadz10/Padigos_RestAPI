import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  const NoteModify({Key? key, this.noteID = " "}) : super(key: key);

  final String noteID;
  bool get isEditing => noteID != " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Create Note')),
      // appBar: AppBar(title: const Text('Create Note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                hintText: 'Note Title',
              ),
            ),
            Container(height: 8),
            const TextField(
              decoration: InputDecoration(
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
