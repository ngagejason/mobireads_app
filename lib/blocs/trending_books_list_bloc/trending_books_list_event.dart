abstract class TrendingBooksListEvent {}

class Initialize extends TrendingBooksListEvent{
  int code;
  String title;

  Initialize(this.code, this.title);
}

class Loaded extends TrendingBooksListEvent{}
