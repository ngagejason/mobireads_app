// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/books/Book.dart';

enum TrendingBooksListStatus {
  Constructed,
  PeeksLoading,
  PeeksLoaded,
  Loaded,
  Error
}

class TrendingBooksListState {

  final List<Book> Books;
  final String Title;
  final TrendingBooksListStatus Status;
  final int? DisplayType;

  TrendingBooksListState ({ this.Books = const[], this.Title = '', this.Status = TrendingBooksListStatus.Constructed, this.DisplayType = 1 });

  TrendingBooksListState CopyWith(
      {
        List<Book>? books,
        String? title,
        TrendingBooksListStatus? status,
        int? displayType
      }) {
    return TrendingBooksListState(
        Books: books ?? this.Books,
        Title: title ?? this.Title,
        Status: status ?? this.Status,
        DisplayType: displayType ?? this.DisplayType
    );
  }
}