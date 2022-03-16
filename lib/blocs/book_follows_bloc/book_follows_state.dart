// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/books/Book.dart';

enum BookFollowsStatus {
  Constructed,
  BookFollowsLoading,
  BookFollowsLoaded,
  Loaded,
  Error
}

class BookFollowsState {

  final List<Book> Books;
  final BookFollowsStatus Status;

  BookFollowsState ({ this.Books = const[], this.Status = BookFollowsStatus.Constructed });

  BookFollowsState CopyWith({ List<Book>? books, BookFollowsStatus? status }) {
    return BookFollowsState(
      Books: books ?? this.Books,
      Status: status ?? this.Status
    );
  }
}