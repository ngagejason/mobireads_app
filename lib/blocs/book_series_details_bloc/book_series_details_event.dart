
import 'package:mobi_reads/entities/books/Book.dart';

abstract class BookSeriesDetailsEvent {}

class InitializeBookSeriesDetails extends BookSeriesDetailsEvent{
  Book book;

  InitializeBookSeriesDetails(this.book);
}

class SeriesLoaded extends BookSeriesDetailsEvent{}
