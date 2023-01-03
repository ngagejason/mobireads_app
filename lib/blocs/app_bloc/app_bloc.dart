import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/classes/UserSecureStorage.dart';
import 'package:mobi_reads/repositories/login_repository.dart';
import 'app_state.dart';
import 'app_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  LoginRepository loginRepository;

  AppBloc(this.loginRepository) : super(AppState('')){
    on<UserLoggedInEvent>((event, emit) async => await handleUserLoggedInEvent(event, emit));
    on<UserLoggedOutEvent>((event, emit) async => await handleUserLoggedOutEvent(event, emit));
  }

  Future handleUserLoggedInEvent(UserLoggedInEvent event, Emitter<AppState> emit) async {
    AppState newState = state.CopyWith(event.id, email: event.email, username: event.username, status: AppStatus.LoggedIn);
    emit(newState);
  }

  Future handleUserLoggedOutEvent(UserLoggedOutEvent event, Emitter<AppState> emit) async {
    if(state.Id.length > 0){
      await loginRepository.logout();
    }

    await UserSecureStorage.clearAll();
    emit(state.CopyWith('', email: '', username: '', status: AppStatus.LoggedOut));
  }
}
