class InsertNote {
  String noteTitle;
  String noteContent;

  InsertNote({
    this.noteTitle = "",
    this.noteContent = "",
  });

  factory InsertNote.fromJson(Map<String, dynamic> item) {
    return InsertNote(
      noteTitle: item['noteTitle'],
      noteContent: item['noteContent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "noteTitle": noteTitle,
      "noteContent": noteContent,
    };
  }
}
