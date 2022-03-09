
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/peek_list_state.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/peek_list_event.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowRequest.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowResponse.dart';
import 'package:mobi_reads/entities/peek/Peek.dart';
import 'package:mobi_reads/entities/peek/PeekResponse.dart';
import 'package:mobi_reads/extension_methods/first_where_or_null.dart';
import 'package:mobi_reads/repositories/book_repository.dart';

import 'package:mobi_reads/repositories/peek_repository.dart';

class PeekListBloc extends Bloc<PeekListEvent, PeekListState> {

  PeekRepository peekRepository;
  BookRepository bookRepository;

  PeekListBloc(this.peekRepository, this.bookRepository) : super(PeekListState()){
    on<Initialize>((event, emit) async => await handleInitializedEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
    on<ToggleFollow>((event, emit) async => await handleToggleFollowEvent(event, emit));
  }

  Future handleInitializedEvent(Initialize event, Emitter<PeekListState> emit) async {
    emit(state.CopyWith(status: PeekListStatus.PeeksLoading));
    PeekResponse response = await peekRepository.getPeeks(event.code);
    emit(state.CopyWith(title: event.title, peeks: response.Peeks, status: PeekListStatus.PeeksLoaded, displayType: response.DisplayType));
  }

  Future handleLoadedEvent(Loaded event, Emitter<PeekListState> emit) async {
    emit(state.CopyWith(status: PeekListStatus.Loaded));
  }

  Future handleToggleFollowEvent(ToggleFollow event, Emitter<PeekListState> emit) async {
    Peek? peek = state.Peeks.firstWhereOrNull((e) => e.BookId == event.bookId);
    if(peek != null){
      ToggleBookFollowResponse resp = await bookRepository.toggleFollow(new ToggleBookFollowRequest(event.bookId));
      peek.DoesFollow = resp.DoesFollow;
      emit(state.CopyWith(status: PeekListStatus.Loaded, peeks: state.Peeks));
    }
  }
}
