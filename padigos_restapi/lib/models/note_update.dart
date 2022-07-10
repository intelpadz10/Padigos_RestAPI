class UpdateNote {
  String noteTitle;
  String noteContent;

  UpdateNote({
    this.noteTitle = "",
    this.noteContent = "",
  });

  factory UpdateNote.fromJson(Map<String, dynamic> item) {
    return UpdateNote(
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
