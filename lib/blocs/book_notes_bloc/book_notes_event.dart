
abstract class BookNotesEvent {}

class InitializeBookNotes extends BookNotesEvent{}

class Loaded extends BookNotesEvent{}

class DeleteNote extends BookNotesEvent{
  String id;
  String bookId;
  DeleteNote(this.id, this.bookId);
}
