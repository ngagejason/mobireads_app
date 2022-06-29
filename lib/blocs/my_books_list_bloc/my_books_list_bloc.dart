
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/my_books_list_bloc/my_books_list_event.dart';
import 'package:mobi_reads/blocs/my_books_list_bloc/my_books_list_state.dart';
import 'package:mobi_reads/entities/books/TrendingBooksResponse.dart';
import 'package:mobi_reads/repositories/book_repository.dart';

class MyBooksListBloc extends Bloc<MyBooksListEvent, MyBooksListState> {

  BookRepository bookRepository;

  MyBooksListBloc(this.bookRepository) : super(MyBooksListState()){
    on<Initialize>((event, emit) async => await handleInitializedEvent(event, emit));
    on<Refresh>((event, emit) async => await handleRefreshEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
  }

  Future handleInitializedEvent(Initialize event, Emitter<MyBooksListState> emit) async {
    try{
      emit(state.CopyWith(status: MyBooksListStatus.MyBooksLoading));
      TrendingBooksResponse response = await bookRepository.getMyBooks();
      emit(state.CopyWith(books: response.Books, status: MyBooksListStatus.MyBooksLoaded));
    }
    on Exception catch(ex){
      emit(state.CopyWith(status: MyBooksListStatus.Error, errorMessage: ex.toString()));
    }
  }

  Future handleRefreshEvent(Refresh event, Emitter<MyBooksListState> emit) async {
    try{
      emit(state.CopyWith(status: MyBooksListStatus.MyBooksRefreshing));
      TrendingBooksResponse response = await bookRepository.getMyBooks();
      emit(state.CopyWith(books: response.Books, status: MyBooksListStatus.MyBooksLoaded));
    }
    on Exception catch(ex){
      emit(state.CopyWith(status: MyBooksListStatus.Error, errorMessage: ex.toString()));
    }
  }

  Future handleLoadedEvent(Loaded event, Emitter<MyBooksListState> emit) async {
    emit(state.CopyWith(status: MyBooksListStatus.Loaded));
  }
}
