class NoteForListing {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime lastEditDateTime;

  NoteForListing(
      {this.noteID = ' ',
      this.noteTitle = ' ',
      DateTime? createDateTime,
      DateTime? lastEditDateTime})
      : createDateTime = createDateTime ?? DateTime.now(),
        lastEditDateTime = lastEditDateTime ?? DateTime.now();

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      createDateTime: DateTime.parse(item['createDateTime']),
      lastEditDateTime: DateTime.parse(item['createDateTime']),
    );
  }
}
