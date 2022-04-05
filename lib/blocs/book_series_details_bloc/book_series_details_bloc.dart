
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_event.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_state.dart';
import 'package:mobi_reads/repositories/book_repository.dart';

class BookSeriesDetailsBloc extends Bloc<BookSeriesDetailsEvent, BookSeriesDetailsState> {

  BookRepository bookRepository;

  BookSeriesDetailsBloc(this.bookRepository) : super(BookSeriesDetailsState()){
    on<InitializeBookSeriesDetails>((event, emit) async => await handleInitializedEvent(event, emit));
    on<SeriesLoaded>((event, emit) async => await handleLoadedEvent(event, emit));
  }

  Future handleInitializedEvent(InitializeBookSeriesDetails event, Emitter<BookSeriesDetailsState> emit) async {
    emit(state.CopyWith(status: BookSeriesDetailsStatus.BookSeriesDetailsLoading));
    emit(state.CopyWith(status: BookSeriesDetailsStatus.BookSeriesDetailsLoaded));
  }

  Future handleLoadedEvent(SeriesLoaded event, Emitter<BookSeriesDetailsState> emit) async {
    emit(state.CopyWith(status: BookSeriesDetailsStatus.Loaded));
  }
}
