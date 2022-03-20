// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/books/Book.dart';

enum BookDetailsStatus {
  Constructed,
  BookDetailsLoading,
  BookDetailsLoaded,
  Loaded,
  Error
}

class BookDetailsState {

  final Book? SelectedBook;
  final BookDetailsStatus Status;

  BookDetailsState ({ this.SelectedBook, this.Status = BookDetailsStatus.Constructed });

  BookDetailsState CopyWith({ Book? book, BookDetailsStatus? status }) {
    return BookDetailsState(
      SelectedBook: book ?? this.SelectedBook,
      Status: status ?? this.Status
    );
  }
}