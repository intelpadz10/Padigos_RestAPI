class NoteForListing {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime lastEditDateTime;

  NoteForListing(
      {this.noteID = "",
      this.noteTitle = "",
      required this.createDateTime,
      required this.lastEditDateTime});
}
