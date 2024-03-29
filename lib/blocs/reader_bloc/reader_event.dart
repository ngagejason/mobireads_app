
import 'package:mobi_reads/entities/books/Book.dart';

abstract class ReaderEvent {}

class InitializeReader extends ReaderEvent{
  Book book;
  bool changeBooks;

  InitializeReader(this.book, this.changeBooks);
}

class InitializeReaderByBookId extends ReaderEvent{
  InitializeReaderByBookId();
}

class ClearBook extends ReaderEvent{}

class LightRefresh extends ReaderEvent{}

class HardRefresh extends ReaderEvent{}

class Loaded extends ReaderEvent{}

class ScrollChanged extends ReaderEvent{
  double offset;
  ScrollChanged(this.offset);
}

class FontSizeChanged extends ReaderEvent{
  double fontSize;
  FontSizeChanged(this.fontSize);
}
