abstract class TrendingBooksEvent {}

class Initialize extends TrendingBooksEvent{
  int code;
  String title;

  Initialize(this.code, this.title);
}

class Loaded extends TrendingBooksEvent{}
