abstract class LoadingPageEvent {}

class TextChanged extends LoadingPageEvent {
  String message;
  TextChanged(this.message);
}

class Rendered extends LoadingPageEvent {
  Rendered();
}
