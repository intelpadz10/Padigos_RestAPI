import 'package:padigos_restapi/models/api_response.dart';
import 'package:padigos_restapi/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NotesService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app/notes';
  static const headers = {'apiKey': 'a0d5c4a1-be34-4c6f-888d-bc77b34cb894'};

  Future<APIResponse<List<NoteForListing>>> getNotesList() async {
    final response = await http.get(Uri.parse(API), headers: headers);
    final notes = <NoteForListing>[];
    if (response.statusCode == 200) {
      final jsonData = convert.jsonDecode(response.body);
      for (var item in jsonData) {
        final note = NoteForListing(
          noteID: item['noteID'],
          noteTitle: item['noteTitle'],
          createDateTime: DateTime.parse(item['createDateTime']),
          lastEditDateTime: DateTime.parse(item['createDateTime']),
        );
        notes.add(note);
      }
    }
    return APIResponse<List<NoteForListing>>(
      data: notes,
    );
  }
}
