import 'package:equatable/equatable.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChapter.dart';
import 'package:mobi_reads/extension_methods/first_where_or_null.dart';
import 'package:json_annotation/json_annotation.dart';

enum ReaderStatus {
  Constructed,
  ChaptersLoading,
  ChaptersLoaded,
  Loaded,
  Error
}

@JsonSerializable()
class ReaderState extends Equatable {

  final ReaderStatus? status;
  List<OutlineChapter> allChapters = List.empty(growable: true);
  final Book? book;
  bool reachedEnd = false;
  bool canEdit = false;
  String errorMessage = '';

  ReaderState ({ this.status = ReaderStatus.Constructed, this.book });

  ReaderState CopyWith({
    ReaderStatus? status,
    Book? book, List<OutlineChapter>?
    updateChapters,
    double? scrollOffset,
    bool? canEdit,
    String? errorMessage }) {

    // New list after all updates
    List<OutlineChapter>? newChapters = List.empty(growable: true);

    // First cycle through and add all existing chapters that have not been deleted
    allChapters.forEach((element) {
      OutlineChapter? updateChapter = updateChapters?.firstWhereOrNull((e) => e.Id == element.Id);
      if(updateChapter == null){
        newChapters.add(element);
      }
      else if(updateChapter.DeletedDateTimeUTC == null){
        newChapters.add(element);
      }
    });

    updateChapters?.forEach((element) {
      OutlineChapter? newChapter = newChapters.firstWhereOrNull((e) => e.Id == element.Id);
      if(newChapter == null){
        newChapters.add(element);
      }
      else{
        newChapter.Title = element.Title;
        newChapter.Writing = element.Writing;
      }
    });

    newChapters.sort((a, b) => a.ChapterNumber > b.ChapterNumber ? 1 : 0);

    ReaderState state = ReaderState(
      status: status ?? this.status,
      book: book ?? this.book
    );

    state.reachedEnd = book?.ChapterCount == newChapters.length;
    state.allChapters = newChapters;
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
