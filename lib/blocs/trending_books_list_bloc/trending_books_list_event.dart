abstract class TrendingBooksListEvent {}

class Initialize extends TrendingBooksListEvent{
  int code;
  String title;

  Initialize(this.code, this.title);
}

class Refresh extends TrendingBooksListEvent{
  int code;
  String title;

  Refresh(this.code, this.title);
}

class Loaded extends TrendingBooksListEvent{}
