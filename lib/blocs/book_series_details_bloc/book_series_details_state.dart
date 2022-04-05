// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/books/Book.dart';

enum BookSeriesDetailsStatus {
  Constructed,
  BookSeriesDetailsLoading,
  BookSeriesDetailsLoaded,
  Loaded,
  Error
}

class BookSeriesDetailsState {

  final List<Book>? Books;
  final BookSeriesDetailsStatus Status;

  BookSeriesDetailsState ({ this.Books, this.Status = BookSeriesDetailsStatus.Constructed });

  BookSeriesDetailsState CopyWith({ List<Book>? books, BookSeriesDetailsStatus? status }) {
    return BookSeriesDetailsState(
      Books: books ?? this.Books,
      Status: status ?? this.Status
    );
  }
}