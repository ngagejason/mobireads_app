
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/peek_bloc/peek_state.dart';
import 'package:mobi_reads/blocs/peek_bloc/peek_event.dart';
import 'package:mobi_reads/entities/peek/PeekResponse.dart';

import 'package:mobi_reads/repositories/peek_repository.dart';

class PeekBloc extends Bloc<PeekEvent, PeekState> {

  PeekRepository peekRepository;

  PeekBloc(this.peekRepository) : super(PeekState()){
    on<Initialized>((event, emit) async => await handleInitializedEvent(event, emit));
  }

  Future handleInitializedEvent(Initialized event, Emitter<PeekState> emit) async {
    PeekResponse response = await peekRepository.getPeeks(event.code);
    emit(state.CopyWith(title: event.title, peeks: response.Peeks, status: PeekStatus.Loaded, displayType: response.DisplayType));
  }
}
