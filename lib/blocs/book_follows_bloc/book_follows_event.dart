
import 'package:mobi_reads/entities/books/Book.dart';

abstract class BookFollowsEvent {}

class InitializeBookFollows extends BookFollowsEvent{}

class Loaded extends BookFollowsEvent{}

class ToggleFollow extends BookFollowsEvent{
  Book book;

  ToggleFollow(this.book);
}