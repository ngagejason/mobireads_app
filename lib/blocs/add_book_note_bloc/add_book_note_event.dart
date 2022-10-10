
abstract class AddBookNoteEvent {}

class AddBookNote extends AddBookNoteEvent {
  String note;
  String bookId;
  String title;

  AddBookNote(this.bookId, this.title, this.note);
}
