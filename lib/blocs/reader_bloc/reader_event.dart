
import 'package:mobi_reads/entities/books/Book.dart';

abstract class ReaderEvent {}

class InitializeReader extends ReaderEvent{
  Book book;
  bool changeBooks;

  InitializeReader(this.book, this.changeBooks);
}

class Refresh extends ReaderEvent{}

class Loaded extends ReaderEvent{}

class LoadChapters extends ReaderEvent{}

class ScrollChanged extends ReaderEvent{
  double offset;
  ScrollChanged(this.offset);
}
