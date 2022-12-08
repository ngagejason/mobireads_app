// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/classes/UserFileStorage.dart';
import 'package:mobi_reads/classes/UserKvpStorage.dart';
import 'package:mobi_reads/classes/UserSecureStorage.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChapter.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChaptersResponse.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineHash.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineHashResponse.dart';
import 'package:mobi_reads/extension_methods/first_where_or_null.dart';
import 'package:mobi_reads/repositories/book_repository.dart';
import 'package:mobi_reads/repositories/outline_repository.dart';
import 'reader_event.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {

  OutlineRepository outlineRepository;
  BookRepository bookRepository;
  Map<String, Function(String? writing, double? fontSize)> funcs = Map();
  Function(double scrollOffset)? setScrollOffset;
  Function(bool setDisplay)? forceRefresh;
  Timer? _debounceScroll;
  Timer? _debounceFont;
  double currentFontSize = -1;
  double currentOffset = -1;
  int currentVersion = -1;

  ReaderBloc(this.outlineRepository, this.bookRepository) : super(ReaderState()){
    on<InitializeReader>((event, emit) async => await handleInitializeEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
    on<LightRefresh>((event, emit) async => await handleLightRefreshEvent(event, emit));
    on<HardRefresh>((event, emit) async => await handleHardRefreshEvent(event, emit));
    on<ScrollChanged>((event, emit) async => await handleScrollChanged(event, emit));
    on<FontSizeChanged>((event, emit) async => await handleFontSizeChanged(event, emit));
    on<InitializeReaderByBookId>((event, emit) async => await handleInitializeByBookIdEvent(event, emit));
  }

  void AddSetState(String id, Function(String? id, double? fontSize) f){
    if(id.length > 0){
      if(!funcs.containsKey(id)){
        funcs[id] = f;
      }
    }
  }

  void RemoveSetState(String id){
    if(id.length > 0){
      if(funcs.containsKey(id)){
        funcs.remove(id);
      }
    }
  }
  
  Future handleInitializeEvent(InitializeReader event, Emitter<ReaderState> emit) async {

    try {

      if(event.book.Id.length == 0){
        emit(state.ClearChapters());
        return;
      }

      await loadBook(emit, event.book);
    }
    on Exception catch (e) {
      emit(state.CopyWith(status: ReaderStatus.Error, errorMessage: 'An error occurred loading the book.'));
    }
  }

  Future handleInitializeByBookIdEvent(InitializeReaderByBookId event, Emitter<ReaderState> emit) async {
    try{
      String currentBookId = await UserKvpStorage.getCurrentBookId();
      if(currentBookId.length > 0){
        Book book = await bookRepository.getBook(currentBookId);
        await handleInitializeEvent(InitializeReader(book, true), emit);
      }
    }
    on Exception catch(ex){
      emit(state.CopyWith(status: ReaderStatus.Error, errorMessage: 'An error occurred loading the book.'));
      UserKvpStorage.clearCurrentBookId();
    }
  }

  Future handleLightRefreshEvent(LightRefresh event, Emitter<ReaderState> emit) async {
    var book = state.book ?? await bookRepository.getBook(state.book!.Id);
    List<OutlineChapter> existingChapters = await UserFileStorage.getChapters(book.Id);
    OutlineHashResponse outlineHashResponse = await outlineRepository.getOutlineHash(book.Id);
    var chapters = await syncBook(existingChapters, outlineHashResponse.OutlineHashes);
    emit(state.CopyWith(status: ReaderStatus.Loaded, book: book, allChapters: chapters));
    refreshView();
  }

  Future handleHardRefreshEvent(HardRefresh event, Emitter<ReaderState> emit) async {
    emit(state.CopyWith(status: ReaderStatus.ChaptersLoading));
    var book = await bookRepository.getBook(state.book!.Id);
    await UserFileStorage.clearBook(state.book!.Id);
    await loadBook(emit, book);
    emit(state.CopyWith(status: ReaderStatus.Loaded, book: book));
    setScrollOffset!(currentOffset);
  }

  Future handleLoadedEvent(Loaded event, Emitter<ReaderState> emit) async {
    refreshView();
    emit(state.CopyWith(status: ReaderStatus.Loaded));
    setScrollOffset!(currentOffset);
  }

  Future handleScrollChanged(ScrollChanged event, Emitter<ReaderState> emit) async {
    if (_debounceScroll?.isActive ?? false){
      _debounceScroll?.cancel();
    }
    _debounceScroll = Timer(const Duration(milliseconds: 500), () async {
      if(state.book != null){
        await UserKvpStorage.setScrollOffset(state.book!.Id, event.offset);
      }
    });
  }

  Future handleFontSizeChanged(FontSizeChanged event, Emitter<ReaderState> emit) async {
    currentFontSize = event.fontSize;
    funcs.forEach((key, value) {
      value(null, event.fontSize);
    });
    saveFontSize(event.fontSize);
  }

  Future<void> loadBook(Emitter<ReaderState> emit, Book book) async {

    emit(state.CopyWith(status: ReaderStatus.ChaptersLoading));

    // Get local book config data
    currentOffset = await UserKvpStorage.getScrollOffset(book.Id);
    currentFontSize = await UserKvpStorage.getFontSize(book.Id);
    BoolResponse canEdit = await bookRepository.canEditBook(book.Id);

    // Load existing chapters from file storage
    List<OutlineChapter> existingChapters = await UserFileStorage.getChapters(book.Id);

    // Load current hashes for book
    OutlineHashResponse outlineHashResponse = await outlineRepository.getOutlineHash(book.Id);

    // Sync the current chapters and hashes. This will also sync the local file system
    List<OutlineChapter> finalChapters = await syncBook(existingChapters, outlineHashResponse.OutlineHashes);

    // Emit the new state
    emit(state.CopyWith(allChapters: finalChapters, status: ReaderStatus.ChaptersLoaded, book: book, canEdit: canEdit.Success));
  }

  Future<List<OutlineChapter>> syncBook(List<OutlineChapter> chapters, List<OutlineHash> hashes) async {

    // Build the list of OutlineChapters. "hashes" will always represent
    // the book so just loop through that and look for existing chapters with
    // the same Id and Hash. Insert null where no matches were found.
    List<OutlineChapter?> allChapters = new List<OutlineChapter?>.generate(hashes.length, (index) => null);
    for(int i = 0; i < hashes.length; i++){
      var chapter = chapters.firstWhereOrNull((x) => x.Id == hashes[i].Id && x.Hash == hashes[i].Hash);
      allChapters[i] = chapter;
      // Go ahead and attempt to delete the chapter so that we can add it after downloading it
      // without a conflicting filename
      if(chapter == null){
        UserFileStorage.deleteChapter(state.book?.Id ?? '0', hashes[i].Id);
      }
    }

    // Now we need to download any chapters that were not found
    for(int i = 0; i < hashes.length; i++){
      if(allChapters[i] == null){
        var chapter = await outlineRepository.getChapter((hashes[i].Id));
        allChapters[i] = chapter;
        UserFileStorage.saveChapter(state.book?.Id ?? '0', chapter);
      }
    }

    List<OutlineChapter> finalChapters = new List<OutlineChapter>.generate(hashes.length, (index) => allChapters[index] ?? new OutlineChapter(hashes[index].Id, 'Error', 'Error', 0, null, ''));
    // At this point finalChapters contains the book. We need to delete
    // from the fs any chapters that are no longer valid
    for(int i = 0; i < chapters.length; i++){
      var chapter = finalChapters.firstWhereOrNull((x) => x.Id == chapters[i].Id && x.Hash == chapters[i].Hash);
      if(chapter == null){
        UserFileStorage.deleteChapter(state.book?.Id ?? '0', hashes[i].Id);
      }
    }

    return finalChapters;
  }

  void refreshView() {
    state.allChapters.forEach((e) {
      if(funcs.containsKey(e.Id)){
        var f = funcs[e.Id];
        f!(e.Writing, null);
      }
    });
  }

  void saveFontSize(double fontSize) async {
    if (_debounceFont?.isActive ?? false){
      _debounceFont?.cancel();
    }
    _debounceFont = Timer(const Duration(milliseconds: 500), () async {
      if(state.book != null){
        await UserKvpStorage.setFontSize(state.book!.Id, fontSize);
      }
    });
  }
}
