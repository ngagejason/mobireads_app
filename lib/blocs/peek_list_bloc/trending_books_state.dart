// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/extension_methods/first_where_or_null.dart';

enum TrendingBooksStatus {
  Constructed,
  PeeksLoading,
  PeeksLoaded,
  Loaded,
  Error
}

class TrendingBooksState {

  final List<Book> Books;
  final String Title;
  final TrendingBooksStatus Status;
  final int? DisplayType;

  TrendingBooksState ({ this.Books = const[], this.Title = '', this.Status = TrendingBooksStatus.Constructed, this.DisplayType = 1 });

  TrendingBooksState CopyWith(
      {
        List<Book>? books,
        String? title,
        TrendingBooksStatus? status,
        int? displayType
      }) {
    return TrendingBooksState(
        Books: books ?? this.Books,
        Title: title ?? this.Title,
        Status: status ?? this.Status,
        DisplayType: displayType ?? this.DisplayType
    );
  }
}