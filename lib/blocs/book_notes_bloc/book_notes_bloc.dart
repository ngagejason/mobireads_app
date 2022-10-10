
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_event.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_state.dart';
import 'package:mobi_reads/entities/book_notes/BookNote.dart';
import 'package:mobi_reads/entities/book_notes/DeleteBookNoteRequest.dart';
import 'package:mobi_reads/repositories/book_note_repository.dart';

class BookNotesBloc extends Bloc<BookNotesEvent, BookNotesState> {

  BookNoteRepository bookNoteRepository;
  String bookId;

  BookNotesBloc(this.bookNoteRepository, this.bookId) : super(BookNotesState()){
    on<InitializeBookNotes>((event, emit) async => await handleInitializedEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
    on<DeleteNote>((event, emit) async => await handleDeleteEvent(event, emit));
  }

  Future handleInitializedEvent(InitializeBookNotes event, Emitter<BookNotesState> emit) async {
    emit(state.CopyWith(status: BookNotesStatus.BookNotesLoading));
    List<BookNote> response = await bookNoteRepository.getBookNotes(bookId);
    emit(state.CopyWith(status: BookNotesStatus.BookNotesLoaded, bookNotes: response));
  }

  Future handleLoadedEvent(Loaded event, Emitter<BookNotesState> emit) async {
    emit(state.CopyWith(status: BookNotesStatus.Loaded));
  }

  Future handleDeleteEvent(DeleteNote event, Emitter<BookNotesState> emit) async {
    List<BookNote> response = await bookNoteRepository.deleteBookNote(new DeleteBookNoteRequest(event.id, event.bookId));
    emit(state.CopyWith(status: BookNotesStatus.BookNotesLoaded, bookNotes: response));
  }
}
