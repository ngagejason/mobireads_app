// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/books/Book.dart';

enum MyBooksListStatus {
  Constructed,
  MyBooksLoading,
  MyBooksLoaded,
  MyBooksRefreshing,
  Loaded,
  Error
}

class MyBooksListState {

  final List<Book> Books;
  final MyBooksListStatus Status;
  final String ErrorMessage;

  MyBooksListState ({ this.Books = const[], this.Status = MyBooksListStatus.Constructed, this.ErrorMessage = "Error" });

  MyBooksListState CopyWith(
      {
        List<Book>? books,
        MyBooksListStatus? status,
        String? errorMessage
      }) {
    return MyBooksListState(
        Books: books ?? this.Books,
        Status: status ?? this.Status,
        ErrorMessage: errorMessage ?? this.ErrorMessage
    );
  }
}