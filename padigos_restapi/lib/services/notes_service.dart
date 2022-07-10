import 'dart:convert';

import 'package:padigos_restapi/models/api_response.dart';
import 'package:padigos_restapi/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:padigos_restapi/models/note_insert.dart';
import 'dart:convert' as convert;

import 'package:padigos_restapi/models/single_note.dart';

class NotesService {
  // ignore: constant_identifier_names
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app/notes';
  static const headers = {
    'apiKey': 'a0d5c4a1-be34-4c6f-888d-bc77b34cb894',
    'Content-Type': 'application/json'
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() async {
    final notes = <NoteForListing>[];
    final response = await http.get(Uri.parse(API), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = convert.jsonDecode(response.body);
      for (var item in jsonData) {
        NoteForListing.fromJson(item);
        notes.add(NoteForListing.fromJson(item));
      }
      return APIResponse<List<NoteForListing>>(
        data: notes,
      );
    }
    return APIResponse<List<NoteForListing>>(
        data: notes, error: true, errorMessage: 'An error occured.');
  }

  Future<APIResponse<SingleNote>> getSingleNote(String noteID) async {
    final response =
        await http.get(Uri.parse('$API/$noteID'), headers: headers);
    final jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // SingleNote.fromJson(jsonData);

      return APIResponse<SingleNote>(
        data: SingleNote.fromJson(jsonData),
      );
    }
    return APIResponse<SingleNote>(
        error: true, errorMessage: 'An error occured.');
  }

  Future<APIResponse<bool>> createNote(InsertNote item) async {
    final response = await http.post(Uri.parse(API),
        headers: headers, body: jsonEncode(item.toJson()));
    final jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 201) {
      // SingleNote.fromJson(jsonData);

      return APIResponse<bool>(
        data: true,
      );
    }
    return APIResponse<bool>(error: true, errorMessage: 'An error occured.');
  }
}
