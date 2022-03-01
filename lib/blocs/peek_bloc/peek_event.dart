import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';

abstract class PeekEvent {}

class Initialized extends PeekEvent{
  int code;
  String title;

  Initialized(this.code, this.title);
}
