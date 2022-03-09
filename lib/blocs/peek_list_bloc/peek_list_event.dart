import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';

abstract class PeekListEvent {}

class Initialize extends PeekListEvent{
  int code;
  String title;

  Initialize(this.code, this.title);
}


class ToggleFollow extends PeekListEvent{
  String bookId;

  ToggleFollow(this.bookId);
}


class Loaded extends PeekListEvent{}
