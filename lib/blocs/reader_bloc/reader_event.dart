
abstract class ReaderEvent {}

class InitializeReader extends ReaderEvent{
  String bookId;
  bool changeBooks;

  InitializeReader(this.bookId, this.changeBooks);
}

class Loaded extends ReaderEvent{}

class LoadChapters extends ReaderEvent{}
