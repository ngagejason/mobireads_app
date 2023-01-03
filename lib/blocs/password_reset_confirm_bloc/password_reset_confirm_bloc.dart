import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/password_reset_confirm_bloc/password_reset_confirm_event.dart';
import 'package:mobi_reads/blocs/password_reset_confirm_bloc/password_reset_confirm_state.dart';
import 'package:mobi_reads/classes/ExceptionFormatter.dart';
import 'package:mobi_reads/classes/UserSecureStorage.dart';
import 'package:mobi_reads/entities/account/password_reset_confirm.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';
import 'package:mobi_reads/repositories/account_repository.dart';


class PasswordResetConfirmBloc extends Bloc<PasswordResetConfirmEvent, PasswordResetConfirmState> {

  AccountRepository accountRepository;

  PasswordResetConfirmBloc(this.accountRepository, String email) : super(PasswordResetConfirmState(email)){
    on<PasswordChanged>((event, emit) async => await handlePasswordChangedEvent(event, emit));
    on<ConfirmationCodeChanged>((event, emit) async => await handleConfirmationCodeChangedEvent(event, emit));
    on<ConfirmRequested>((event, emit) async => await handleConfirmRequestedEvent(emit));
    on<Confirm>((event, emit) async => await handleConfirmEvent(emit));
    on<RedirectToHome>((event, emit) async => await handleRedirectToHomeEvent(emit));
  }

  Future handlePasswordChangedEvent(PasswordChanged event, Emitter<PasswordResetConfirmState> emit) async {
    emit(state.CopyWith(password: event.password, status: PasswordResetConfirmStatus.UserInput));
  }

  Future handleConfirmationCodeChangedEvent(ConfirmationCodeChanged event, Emitter<PasswordResetConfirmState> emit) async {
    emit(state.CopyWith(confirmationCode: event.confirmationCode, status: PasswordResetConfirmStatus.UserInput));
  }

  Future handleConfirmRequestedEvent(Emitter<PasswordResetConfirmState> emit) async {
    emit(state.CopyWith(status: PasswordResetConfirmStatus.ConfirmRequested));
  }

  Future handleConfirmEvent(Emitter<PasswordResetConfirmState> emit) async {
    emit(state.CopyWith(status: PasswordResetConfirmStatus.SendingConfirm));
    try {
      LoginUserResponse response = await accountRepository.sendPasswordResetConfirm(
        PasswordResetConfirm(state.Email, state.Password, state.ConfirmationCode)
      );

      if(!response.Success){
        emit(state.CopyWith(errorMessage: response.Message ?? 'Unknown Error', status: PasswordResetConfirmStatus.Error));
        return;
      }

      await UserSecureStorage.setBearerToken(response.Bearer);
      emit(state.CopyWith(status: PasswordResetConfirmStatus.Confirmed, login: response));
    }
    on Exception catch (e) {
      emit(state.CopyWith(errorMessage: ExceptionFormatter.FormatException(e), status: PasswordResetConfirmStatus.Error));
    }
  }

  Future handleRedirectToHomeEvent(Emitter<PasswordResetConfirmState> emit) async {
    emit(state.CopyWith(status: PasswordResetConfirmStatus.RedirectToHome));
  }
}
