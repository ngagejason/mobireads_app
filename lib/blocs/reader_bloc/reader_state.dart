import 'package:equatable/equatable.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChapter.dart';
import 'package:mobi_reads/extension_methods/first_where_or_null.dart';
import 'package:json_annotation/json_annotation.dart';

enum ReaderStatus {
  Constructed,
  ChaptersLoading,
  ChaptersLoaded,
  Loaded,
  ChangingFont,
  Error
}

@JsonSerializable()
class ReaderState extends Equatable {

  final ReaderStatus? status;
  List<OutlineChapter> allChapters = List.empty(growable: true);
  final Book? book;
  bool canEdit = false;
  String errorMessage = '';

  ReaderState ({ this.status = ReaderStatus.Constructed, this.book });

  ReaderState CopyWith({
    ReaderStatus? status,
    Book? book,
    List<OutlineChapter>? allChapters,
    bool? canEdit,
    String? errorMessage }) {

    ReaderState state = ReaderState(
      status: status ?? this.status,
      book: book ?? this.book
    );

    state.allChapters = allChapters ?? this.allChapters;
    state.canEdit = canEdit ?? this.canEdit;
    state.errorMessage = errorMessage ?? this.errorMessage;

    return state;
  }

  ReaderState ClearChapters(){
    ReaderState state = ReaderState(
      status: this.status,
        book: book
    );

    state.allChapters = [];
    return state;
  }

  @override
  List<Object?> get props => [status, allChapters];
}
