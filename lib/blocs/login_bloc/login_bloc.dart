import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/login_bloc/login_event.dart';
import 'package:mobi_reads/blocs/login_bloc/login_state.dart';
import 'package:mobi_reads/classes/ExceptionFormatter.dart';
import 'package:mobi_reads/classes/UserSecureStorage.dart';
import 'package:mobi_reads/entities/login/LoginUserRequest.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';
import 'package:mobi_reads/repositories/login_repository.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(LoginState()){
    on<EmailChanged>((event, emit) async => await handleEmailChangedEvent(event, emit));
    on<PasswordChanged>((event, emit) async => await handlePasswordChangedEvent(event, emit));
    on<LoginRequested>((event, emit) async => await handleLoginRequestedEvent(emit));
    on<Login>((event, emit) async => await handleLoginEvent(emit));
    on<RedirectToHome>((event, emit) async => await handleRedirectToHomeEvent(event, emit));
    on<ContinueAsGuest>((event, emit) async => await handleContinueAsGuestEvent(emit));
  }

  Future handleEmailChangedEvent(EmailChanged event, Emitter<LoginState> emit) async {
    emit(state.CopyWith(email: event.email, status: LoginStatus.UserInput));
  }

  Future handlePasswordChangedEvent(PasswordChanged event, Emitter<LoginState> emit) async {
    emit(state.CopyWith(password: event.password, status: LoginStatus.UserInput));
  }

  Future handleLoginRequestedEvent(Emitter<LoginState> emit) async {
    emit(state.CopyWith(status: LoginStatus.LoginRequested));
  }

  Future handleLoginEvent(Emitter<LoginState> emit) async {
    emit(state.CopyWith(status: LoginStatus.LoggingIn));
    try {
      LoginUserResponse response = await loginRepository.login(
        LoginUserRequest(state.Email, state.Password)
      );

      if(!response.Success){
        emit(state.CopyWith(errorMessage: response.Message ?? 'Unknown Error', status: LoginStatus.Error));
        return;
      }

      emit(state.CopyWith(status: LoginStatus.LoggedIn, login: response));
    }
    on Exception catch (e) {
      emit(state.CopyWith(errorMessage: ExceptionFormatter.FormatException(e), status: LoginStatus.Error));
    }
  }

  Future handleRedirectToHomeEvent(RedirectToHome event, Emitter<LoginState> emit) async {
    await ensureAppStateSaved(event.userId);
    emit(state.CopyWith(status: LoginStatus.RedirectToHome));
  }

  // There is a race condition that exists. The storage mechanism begins to store the data,
  // however it doesn't complete by the time that the login page triggers a redirect to home
  // which immediately tries to load preferences using the saved state. Because the state
  // isn't saved we get an exception. We have to wait until the UserSecureStorage saves.
  // I hate this, but eh, it's my party so I'll cry if I want to.
  Future ensureAppStateSaved(String userId) async {
    int counter = 0;
    while(await UserSecureStorage.getAppState(userId) == null) {
      await Future.delayed(Duration(milliseconds: 100));
      counter += 1;
      if(counter > 10){
        throw Exception("Failed to load user");
      }
    }
  }

  Future handleContinueAsGuestEvent(Emitter<LoginState> emit) async {
    emit(state.CopyWith(status: LoginStatus.LoggingIn));
    try {
      LoginUserResponse response = await loginRepository.loginAsGuest();

      if(!response.Success){
        emit(state.CopyWith(errorMessage: response.Message ?? 'Unknown Error', status: LoginStatus.Error));
        return;
      }

      emit(state.CopyWith(status: LoginStatus.LoggedIn, login: response));
    }
    on Exception catch (e) {
      emit(state.CopyWith(errorMessage: ExceptionFormatter.FormatException(e), status: LoginStatus.Error));
    }
  }
}
