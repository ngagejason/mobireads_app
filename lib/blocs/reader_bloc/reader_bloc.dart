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
import 'package:mobi_reads/repositories/book_repository.dart';
import 'package:mobi_reads/repositories/outline_repository.dart';
import 'reader_event.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {

  OutlineRepository outlineRepository;
  BookRepository bookRepository;
  Map<String, Function(String? writing, double? fontSize)> funcs = Map();
  Function(double scrollOffset)? setScrollOffset;
  Timer? _debounceScroll;
  Timer? _debounceFont;
  double currentFontSize = -1;
  int currentVersion = -1;

  ReaderBloc(this.outlineRepository, this.bookRepository) : super(ReaderState()){
    on<InitializeReader>((event, emit) async => await handleInitializeEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
    on<LoadChapters>((event, emit) async => await handleLoadChapters(event, emit));
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

      // If a new version exists, we need to delete all existing files because
      // the getChapters will return all chapters
      currentVersion = await UserKvpStorage.getBookVersion(event.book.Id);
      if(currentVersion != event.book.Version){
        await UserFileStorage.clearBook(event.book.Id);
        await UserKvpStorage.setBookVersion(event.book.Id, event.book.Version);
      }

      currentFontSize = await UserKvpStorage.getFontSize(event.book.Id);
      emit(state.CopyWith(status: ReaderStatus.ChaptersLoading, book: event.book));

      if(event.changeBooks){
        emit(state.ClearChapters());
      }

      BoolResponse response = await bookRepository.canEditBook(event.book.Id);

      if(event.book.Id.length > 0){
        List<OutlineChapter> chapters = await UserFileStorage.getChapters(event.book.Id);
        if(chapters.length == 0){
          OutlineChaptersResponse chapters = await outlineRepository.getChapters(event.book.Id, 0, 1000);
          emit(state.CopyWith(updateChapters: chapters.Chapters, status: ReaderStatus.ChaptersLoaded, book: event.book, canEdit: response.Success));
          await UserFileStorage.saveChapters(event.book.Id, chapters.Chapters);
        }
        else{
          // Load offset
          double offset = await UserKvpStorage.getScrollOffset(event.book.Id);

          // Save existing chapters
          ReaderState newState = state.CopyWith(updateChapters: chapters);

          // Check for new chapters
          OutlineChaptersResponse newChapters = await outlineRepository.getChapters(event.book.Id, 0, 1000);

          // if new chapters exist, add them to the new state
          if(newChapters.Chapters.length > 0){
            newState = newState.CopyWith(updateChapters: newChapters.Chapters, status: ReaderStatus.ChaptersLoaded, book: event.book, canEdit: response.Success);
            await UserFileStorage.saveChapters(event.book.Id, newChapters.Chapters);
          }

          emit(newState);

          // Update UI elements
          setScrollOffset!(offset);
        }
      }
      else{
        emit(state.CopyWith(status: ReaderStatus.ChaptersLoaded));
      }
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
    if(state.book != null){
      OutlineChaptersResponse chapters = await outlineRepository.getChapters(state.book?.Id ?? '', 0, 1000);
      if(chapters.Chapters.length > 0){
        ReaderState newState = state.CopyWith(updateChapters: chapters.Chapters, status: ReaderStatus.ChaptersLoaded);
        emit(newState);
        chapters.Chapters.forEach((e) {
          if(funcs.containsKey(e.Id)){
            var f = funcs[e.Id];
            f!(e.Writing, null);
          }
        });
        
        await UserFileStorage.saveChapters(state.book!.Id, chapters.Chapters);
      }
    }
  }

  Future handleHardRefreshEvent(HardRefresh event, Emitter<ReaderState> emit) async {

    var book = await bookRepository.getBook(state.book!.Id);
    emit(state.CopyWith(status: ReaderStatus.ChaptersLoading, book: book));

    await UserFileStorage.clearBook(state.book!.Id);
    await UserKvpStorage.setBookVersion(state.book!.Id, book.Version);
    await outlineRepository.resetLastPoll(state.book!.Id);

    OutlineChaptersResponse chapters = await outlineRepository.getChapters(state.book?.Id ?? '', 0, 1000);
    if(chapters.Chapters.length > 0){
      ReaderState newState = state.CopyWith(updateChapters: chapters.Chapters, status: ReaderStatus.ChaptersLoaded);
      emit(newState);
      chapters.Chapters.forEach((e) {
        if(funcs.containsKey(e.Id)){
          var f = funcs[e.Id];
          f!(e.Writing, null);
        }
      });

      await UserFileStorage.saveChapters(state.book!.Id, chapters.Chapters);
    }
  }

  Future handleLoadedEvent(Loaded event, Emitter<ReaderState> emit) async {
    emit(state.CopyWith(status: ReaderStatus.Loaded));
  }

  Future handleLoadChapters(LoadChapters event, Emitter<ReaderState> emit) async {
    if(!state.reachedEnd){
      emit(state.CopyWith(status: ReaderStatus.ChaptersLoading));
      OutlineChaptersResponse chapters = await outlineRepository.getChapters(state.book?.Id ?? '', state.allChapters.length, 5);
      ReaderState newState = state.CopyWith(status: ReaderStatus.Loaded, updateChapters:  chapters.Chapters);
      await UserFileStorage.saveChapters(state.book?.Id ?? '', chapters.Chapters);
      emit(newState);
    }
  }

  Future handleScrollChanged(ScrollChanged event, Emitter<ReaderState> emit) async {
    saveScroll(event.offset);
  }

  Future handleFontSizeChanged(FontSizeChanged event, Emitter<ReaderState> emit) async {
    currentFontSize = event.fontSize;
    funcs.forEach((key, value) {
      value(null, event.fontSize);
    });
    saveFontSize(event.fontSize);
  }

  void saveScroll(double scrollOffset) async {
    if (_debounceScroll?.isActive ?? false){
      _debounceScroll?.cancel();
    }
    _debounceScroll = Timer(const Duration(milliseconds: 500), () async {
      if(state.book != null){
        await UserKvpStorage.setScrollOffset(state.book!.Id, scrollOffset);
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
