// ignore_for_file: non_constant_identifier_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/classes/UserSecureStorage.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChaptersResponse.dart';
import 'package:mobi_reads/repositories/outline_repository.dart';
import 'reader_event.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {

  OutlineRepository outlineRepository;

  ReaderBloc(this.outlineRepository) : super(ReaderState()){
    on<InitializeReader>((event, emit) async => await handleInitializeEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
    on<LoadChapters>((event, emit) async => await handleLoadChapters(event, emit));
  }

  Future handleInitializeEvent(InitializeReader event, Emitter<ReaderState> emit) async {
    emit(state.CopyWith(status: ReaderStatus.ChaptersLoading, bookId: event.bookId));
    if(event.changeBooks){
      emit(state.ClearChapters(event.bookId));
    }

    if(event.bookId.length > 0){
      ReaderState? memState = await UserSecureStorage.getReaderState(event.bookId);
      if(memState == null){
        OutlineChaptersResponse chapters = await outlineRepository.getChapters(event.bookId, 0, 5);
        memState = state.CopyWith(updateChapters: chapters.Chapters, status: ReaderStatus.ChaptersLoaded, bookId: event.bookId);
        await UserSecureStorage.storeReaderState(event.bookId, memState);
        emit(memState);
      }
      else{
        ReaderState newState = state.CopyWith(updateChapters: memState.allChapters);
        OutlineChaptersResponse chapters = await outlineRepository.getChapters(event.bookId, 0, 1);
        newState = newState.CopyWith(updateChapters: memState.allChapters, status: ReaderStatus.ChaptersLoaded, bookId: event.bookId);
        await UserSecureStorage.storeReaderState(event.bookId, memState);
        emit(newState);
      }
    }
    else{
      emit(state.CopyWith(status: ReaderStatus.ChaptersLoaded));
    }
  }

  Future handleLoadedEvent(Loaded event, Emitter<ReaderState> emit) async {
    emit(state.CopyWith(status: ReaderStatus.Loaded));
  }

  Future handleLoadChapters(LoadChapters event, Emitter<ReaderState> emit) async {
    emit(state.CopyWith(status: ReaderStatus.ChaptersLoading));
    OutlineChaptersResponse chapters = await outlineRepository.getChapters(state.bookId ?? '', state.allChapters.length, 5);
    emit(state.CopyWith(status: ReaderStatus.Loaded, updateChapters:  chapters.Chapters));
  }
}
