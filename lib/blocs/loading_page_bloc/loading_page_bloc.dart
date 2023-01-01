import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/loading_page_bloc/loading_page_event.dart';
import 'package:mobi_reads/blocs/loading_page_bloc/loading_page_state.dart';

class LoadingPageBloc extends Bloc<LoadingPageEvent, LoadingPageState> {

  LoadingPageBloc() : super(LoadingPageState()){
    on<Rendered>((event, emit) async => await handleRenderedEvent(event, emit));
    on<TextChanged>((event, emit) async => await handleTextChangedEvent(event, emit));
  }

  Future handleRenderedEvent(Rendered event, Emitter<LoadingPageState> emit) async {
    emit(state.CopyWith(status: LoadingPageStatus.Ready));
  }

  Future handleTextChangedEvent(TextChanged event, Emitter<LoadingPageState> emit) async {
    emit(state.CopyWith(message: event.message, status: LoadingPageStatus.TextChanged));
  }
}
