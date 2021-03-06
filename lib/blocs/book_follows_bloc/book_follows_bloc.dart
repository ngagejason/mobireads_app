
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_event.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/entities/books/AllBookFollowsResponse.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowRequest.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowResponse.dart';
import 'package:mobi_reads/extension_methods/string_extensions.dart';
import 'package:mobi_reads/repositories/book_repository.dart';

class BookFollowsBloc extends Bloc<BookFollowsEvent, BookFollowsState> {

  BookRepository bookRepository;

  BookFollowsBloc(this.bookRepository) : super(BookFollowsState()){
    on<InitializeBookFollows>((event, emit) async => await handleInitializedEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
    on<ToggleFollow>((event, emit) async => await handleToggleFollowEvent(event, emit));
  }

  Future handleInitializedEvent(InitializeBookFollows event, Emitter<BookFollowsState> emit) async {
    try{
      emit(state.CopyWith(status: BookFollowsStatus.BookFollowsLoading));
      AllBookFollowsResponse response = await bookRepository.getAllBookFollows();
      emit(state.CopyWith(books: response.FollowedBooks, status: BookFollowsStatus.BookFollowsLoaded));
    }
    on Exception catch(ex){
      emit(state.CopyWith(status: BookFollowsStatus.Error, errorMessage: ex.toString()));
    }
  }

  Future handleLoadedEvent(Loaded event, Emitter<BookFollowsState> emit) async {
    emit(state.CopyWith(status: BookFollowsStatus.Loaded));
  }

  Future handleToggleFollowEvent(ToggleFollow event, Emitter<BookFollowsState> emit) async {
    ToggleBookFollowResponse resp = await bookRepository.toggleFollow(new ToggleBookFollowRequest(event.book.Id));
    List<Book> books = List.empty(growable: true);
    // Let's keep this simple. First recreate the books list
    // without the book
    for(Book b in state.Books){
      if(b.Id != event.book.Id){
        books.add(b);
      }
    }

    // Now if the response.doesFollow = true, add it
    if(resp.DoesFollow){
      books.add(event.book);
    }

    // Sort by Title
    books.sort((e, a) => e.Title.guarantee().compareTo(a.Title.guarantee()));

    emit(state.CopyWith(books: books));
  }
}
