
abstract class BookFollowsEvent {}

class Initialize extends BookFollowsEvent{
  Initialize();
}

class Loaded extends BookFollowsEvent{}
