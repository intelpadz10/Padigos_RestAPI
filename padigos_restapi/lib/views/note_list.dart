import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:padigos_restapi/models/api_response.dart';
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

  late APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Note List')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
                    MaterialPageRoute(builder: (context) => const NoteModify()))
                .then((context) {
              _fetchNotes();
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Builder(
          builder: (context) {
            if (_isLoading) {
              return const CircularProgressIndicator();
            }

            if (_apiResponse.error) {
              return Center(child: Text(_apiResponse.errorMessage));
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                  height: 1, color: Color.fromARGB(255, 174, 170, 155)),
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.data![index].noteID),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context,
                        builder: (context) => const NoteDelete());
                    return result;
                  },
                  background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.only(left: 16),
                      child: const Align(
                          child: Icon(Icons.delete, color: Colors.white))),
                  child: ListTile(
                      title: Text(_apiResponse.data![index].noteTitle,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 100, 10, 255))),
                      subtitle: Text(
                          'Last edited on ${formatDateTime(_apiResponse.data![index].lastEditDateTime)}'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NoteModify(
                                noteID: _apiResponse.data![index].noteID)));
                      }),
                );
              },
              itemCount: _apiResponse.data!.length,
            );
          },
        ));
  }
}
