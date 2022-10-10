// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/book_notes/BookNote.dart';
import 'package:mobi_reads/entities/books/Book.dart';

enum AddBookNoteStatus {
  Constructed,
  BookNoteAdding,
  BookNoteAdded,
  Error
}

class AddBookNoteState {

  final AddBookNoteStatus Status;
  final String Error;

  AddBookNoteState ({ this.Status = AddBookNoteStatus.Constructed , this.Error = ''});

  AddBookNoteState CopyWith({ AddBookNoteStatus? status, String? error }) {
    return AddBookNoteState(
      Status: status ?? this.Status,
      Error: error ?? this.Error
    );
  }
}