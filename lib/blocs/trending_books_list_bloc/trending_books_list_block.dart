
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_event.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_state.dart';
import 'package:mobi_reads/entities/books/TrendingBooksResponse.dart';
import 'package:mobi_reads/repositories/book_repository.dart';

class TrendingBooksListBloc extends Bloc<TrendingBooksListEvent, TrendingBooksListState> {

  BookRepository bookRepository;

  TrendingBooksListBloc(this.bookRepository) : super(TrendingBooksListState()){
    on<Initialize>((event, emit) async => await handleInitializedEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
  }

  Future handleInitializedEvent(Initialize event, Emitter<TrendingBooksListState> emit) async {
    emit(state.CopyWith(status: TrendingBooksListStatus.PeeksLoading));
    TrendingBooksResponse response = await bookRepository.getTrendingBooks(event.code);
    emit(state.CopyWith(title: event.title, books: response.Books, status: TrendingBooksListStatus.PeeksLoaded, displayType: response.DisplayType));
  }

  Future handleLoadedEvent(Loaded event, Emitter<TrendingBooksListState> emit) async {
    emit(state.CopyWith(status: TrendingBooksListStatus.Loaded));
  }
}
