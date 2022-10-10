
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_bloc.dart';

class AddBookNoteParams {

  BookNotesBloc bookNotesBloc;
  String bookId;

  AddBookNoteParams(this.bookNotesBloc, this.bookId);

}