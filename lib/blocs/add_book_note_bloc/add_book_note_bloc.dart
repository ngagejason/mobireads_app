
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/add_book_note_bloc/add_book_note_event.dart';
import 'package:mobi_reads/blocs/add_book_note_bloc/add_book_note_state.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_bloc.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_event.dart';
import 'package:mobi_reads/entities/book_notes/AddBookNoteRequest.dart';
import 'package:mobi_reads/entities/book_notes/BookNote.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/repositories/book_note_repository.dart';

class AddBookNoteBloc extends Bloc<AddBookNoteEvent, AddBookNoteState> {

  BookNoteRepository bookNoteRepository;
  BookNotesBloc? bookNotesBloc;

  AddBookNoteBloc(this.bookNoteRepository, this.bookNotesBloc) : super(AddBookNoteState()){
    on<AddBookNote>((event, emit) async => await handleAddBookNoteEvent(event, emit));
  }

  Future handleAddBookNoteEvent(AddBookNote event, Emitter<AddBookNoteState> emit) async {
    try{
      emit(state.CopyWith(status: AddBookNoteStatus.BookNoteAdding));
      BoolResponse response = await bookNoteRepository.addBookNote(new AddBookNoteRequest(event.bookId, event.title, event.note));
      if(response.Success){
        bookNotesBloc?.add(InitializeBookNotes());
        emit(state.CopyWith(status: AddBookNoteStatus.BookNoteAdded));
      }
      else{
        emit(state.CopyWith(status: AddBookNoteStatus.Error, error: response.Message));
      }
    }
    on Exception catch(e){
      emit(state.CopyWith(status: AddBookNoteStatus.Error, error: e.toString()));
    }
  }
}
