// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/extension_methods/first_where_or_null.dart';

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


  isBookFollowed(String bookId){
    Book? b = this.Books.firstWhereOrNull((e) => e.Id == bookId);
    if(b == null){
      return false;
    }

    return true;
  }

  BookFollowsState CopyWith({ List<Book>? books, BookFollowsStatus? status }) {
    return BookFollowsState(
      Books: books ?? this.Books,
      Status: status ?? this.Status
    );
  }
}