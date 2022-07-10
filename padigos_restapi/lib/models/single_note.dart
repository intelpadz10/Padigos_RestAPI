class SingleNote {
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime lastEditDateTime;

  SingleNote(
      {this.noteID = "",
      this.noteTitle = "",
      this.noteContent = "",
      DateTime? createDateTime,
      DateTime? lastEditDateTime})
      : createDateTime = createDateTime ?? DateTime.now(),
        lastEditDateTime = lastEditDateTime ?? DateTime.now();

  factory SingleNote.fromJson(Map<String, dynamic> item) {
    return SingleNote(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      noteContent: item['noteContent'],
      createDateTime: DateTime.parse(item['createDateTime']),
      lastEditDateTime: DateTime.parse(item['createDateTime']),
    );
  }
}
