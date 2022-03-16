
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_event.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/entities/books/AllBookFollowsResponse.dart';
import 'package:mobi_reads/repositories/book_repository.dart';

class BookFollowsBloc extends Bloc<BookFollowsEvent, BookFollowsState> {

  BookRepository bookRepository;

  BookFollowsBloc(this.bookRepository) : super(BookFollowsState()){
    on<Initialize>((event, emit) async => await handleInitializedEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
  }

  Future handleInitializedEvent(Initialize event, Emitter<BookFollowsState> emit) async {
    emit(state.CopyWith(status: BookFollowsStatus.BookFollowsLoading));
    AllBookFollowsResponse response = await bookRepository.getAllBookFollows();
    emit(state.CopyWith(books: response.FollowedBooks, status: BookFollowsStatus.BookFollowsLoaded));
  }

  Future handleLoadedEvent(Loaded event, Emitter<BookFollowsState> emit) async {
    emit(state.CopyWith(status: BookFollowsStatus.Loaded));
  }
}
