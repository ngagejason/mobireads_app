
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/trending_books_event.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/trending_books_state.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowRequest.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowResponse.dart';
import 'package:mobi_reads/entities/books/TrendingBooksResponse.dart';
import 'package:mobi_reads/extension_methods/first_where_or_null.dart';
import 'package:mobi_reads/repositories/book_repository.dart';

class TrendingBooksBloc extends Bloc<TrendingBooksEvent, TrendingBooksState> {

  BookRepository bookRepository;

  TrendingBooksBloc(this.bookRepository) : super(TrendingBooksState()){
    on<Initialize>((event, emit) async => await handleInitializedEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
  }

  Future handleInitializedEvent(Initialize event, Emitter<TrendingBooksState> emit) async {
    emit(state.CopyWith(status: TrendingBooksStatus.PeeksLoading));
    TrendingBooksResponse response = await bookRepository.getTrendingBooks(event.code);
    emit(state.CopyWith(title: event.title, books: response.Books, status: TrendingBooksStatus.PeeksLoaded, displayType: response.DisplayType));
  }

  Future handleLoadedEvent(Loaded event, Emitter<TrendingBooksState> emit) async {
    emit(state.CopyWith(status: TrendingBooksStatus.Loaded));
  }
}
