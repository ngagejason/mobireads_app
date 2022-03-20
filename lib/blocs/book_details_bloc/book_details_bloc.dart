
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_details_bloc/book_details_event.dart';
import 'package:mobi_reads/blocs/book_details_bloc/book_details_state.dart';
import 'package:mobi_reads/repositories/book_repository.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {

  BookRepository bookRepository;

  BookDetailsBloc(this.bookRepository) : super(BookDetailsState()){
    on<InitializeBookDetails>((event, emit) async => await handleInitializedEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
  }

  Future handleInitializedEvent(InitializeBookDetails event, Emitter<BookDetailsState> emit) async {
    emit(state.CopyWith(status: BookDetailsStatus.BookDetailsLoading));
    emit(state.CopyWith(status: BookDetailsStatus.BookDetailsLoaded));
  }

  Future handleLoadedEvent(Loaded event, Emitter<BookDetailsState> emit) async {
    emit(state.CopyWith(status: BookDetailsStatus.Loaded));
  }
}
