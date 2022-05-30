// ignore_for_file: non_constant_identifier_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/classes/UserSecureStorage.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChaptersResponse.dart';
import 'package:mobi_reads/repositories/outline_repository.dart';
import 'reader_event.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {

  OutlineRepository outlineRepository;
  Map<String, Function(String id)> funcs = Map();

  ReaderBloc(this.outlineRepository) : super(ReaderState()){
    on<InitializeReader>((event, emit) async => await handleInitializeEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
    on<LoadChapters>((event, emit) async => await handleLoadChapters(event, emit));
    on<Refresh>((event, emit) async => await handleRefreshEvent(event, emit));
    on<ScrollChanged>((event, emit) async => await handleScrollChanged(event, emit));
  }

  void AddSetState(String id, Function(String id) f){
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
    emit(state.CopyWith(status: ReaderStatus.ChaptersLoading, book: event.book));
    if(event.changeBooks){
      emit(state.ClearChapters());
    }

    if(event.book.Id.length > 0){
      ReaderState? memState = await UserSecureStorage.getReaderState(event.book.Id);
      if(memState == null){
        OutlineChaptersResponse chapters = await outlineRepository.getChapters(event.book.Id, 0, 5);
        memState = state.CopyWith(updateChapters: chapters.Chapters, status: ReaderStatus.ChaptersLoaded, book: event.book);
        await UserSecureStorage.storeReaderState(event.book.Id, memState);
        emit(memState);
      }
      else{
        ReaderState newState = state.CopyWith(updateChapters: memState.allChapters);
        OutlineChaptersResponse chapters = await outlineRepository.getChapters(event.book.Id, 0, 1);
        newState = newState.CopyWith(updateChapters: chapters.Chapters, status: ReaderStatus.ChaptersLoaded, book: event.book);
        await UserSecureStorage.storeReaderState(event.book.Id, newState);
        emit(newState);
      }
    }
    else{
      emit(state.CopyWith(status: ReaderStatus.ChaptersLoaded));
    }
  }

  Future handleRefreshEvent(Refresh event, Emitter<ReaderState> emit) async {

    if(state.book != null){
      OutlineChaptersResponse chapters = await outlineRepository.getChapters(state.book?.Id ?? '', 0, 2);
      if(chapters.Chapters.length > 0){
        ReaderState newState = state.CopyWith(updateChapters: chapters.Chapters, status: ReaderStatus.ChaptersLoaded);
        await UserSecureStorage.storeReaderState(state.book?.Id ?? '', newState);
        emit(newState);
        chapters.Chapters.forEach((e) {
          if(funcs.containsKey(e.Id)){
            var f = funcs[e.Id];
            f!(e.Writing);
          }
        });
      }
    }
  }

  Future handleLoadedEvent(Loaded event, Emitter<ReaderState> emit) async {
    emit(state.CopyWith(status: ReaderStatus.Loaded));
  }

  Future handleLoadChapters(LoadChapters event, Emitter<ReaderState> emit) async {
    if(!state.reachedEnd){
      emit(state.CopyWith(status: ReaderStatus.ChaptersLoading));
      OutlineChaptersResponse chapters = await outlineRepository.getChapters(state.book?.Id ?? '', state.allChapters.length, 5);
      emit(state.CopyWith(status: ReaderStatus.Loaded, updateChapters:  chapters.Chapters));
    }
  }

  Future handleScrollChanged(ScrollChanged event, Emitter<ReaderState> emit) async {
    state.scrollOffset = event.offset;
  }
}
