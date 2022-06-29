abstract class MyBooksListEvent {}

class Initialize extends MyBooksListEvent{
  Initialize();
}

class Refresh extends MyBooksListEvent{
  Refresh();
}

class Loaded extends MyBooksListEvent{}
