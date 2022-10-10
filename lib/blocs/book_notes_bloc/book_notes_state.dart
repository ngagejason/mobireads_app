// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/book_notes/BookNote.dart';
import 'package:mobi_reads/entities/books/Book.dart';

enum BookNotesStatus {
  Constructed,
  BookNotesLoading,
  BookNotesLoaded,
  Loaded,
  Error
}

class BookNotesState {

  final BookNotesStatus Status;
  final List<BookNote> BookNotes;
  BookNotesState ({ this.BookNotes = const[], this.Status = BookNotesStatus.Constructed });

  BookNotesState CopyWith({ List<BookNote>? bookNotes, BookNotesStatus? status }) {
    return BookNotesState(
      BookNotes: bookNotes ?? this.BookNotes,
      Status: status ?? this.Status
    );
  }
}