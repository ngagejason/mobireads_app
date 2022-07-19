import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/confirm_account_bloc/confirm_account_event.dart';
import 'package:mobi_reads/blocs/confirm_account_bloc/confirm_account_state.dart';
import 'package:mobi_reads/entities/account/confirm_account_request.dart';
import 'package:mobi_reads/entities/account/resend_confirmation_code_request.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';
import 'package:mobi_reads/repositories/account_repository.dart';

class ConfirmAccountBloc extends Bloc<ConfirmAccountEvent, ConfirmAccountState> {

  AccountRepository accountRepository;

  ConfirmAccountBloc(this.accountRepository, String email) : super(ConfirmAccountState(Email: email)){
    on<EmailChanged>((event, emit) async => await handleEmailChangedEvent(event, emit));
    on<ConfirmationCodeChanged>((event, emit) async => await handleConfirmationCodeChangedEvent(event, emit));
    on<ConfirmAccountRequested>((event, emit) async => await handleConfirmAccountRequestedEvent(emit));
    on<ConfirmAccount>((event, emit) async => await handleConfirmAccountEvent(emit));
    on<RedirectToHome>((event, emit) async => await handleRedirectToHomeEvent(emit));
    on<ResendRequested>((event, emit) async => await handleResendRequested(emit));
  }

  Future handleEmailChangedEvent(EmailChanged event, Emitter<ConfirmAccountState> emit) async {
    emit(state.CopyWith(email: event.email, status: ConfirmAccountStatus.UserInput));
  }

  Future handleConfirmationCodeChangedEvent(ConfirmationCodeChanged event, Emitter<ConfirmAccountState> emit) async {
    emit(state.CopyWith(confirmationCode: event.confirmationCode, status: ConfirmAccountStatus.UserInput));
  }

  Future handleConfirmAccountRequestedEvent(Emitter<ConfirmAccountState> emit) async {
    emit(state.CopyWith(status: ConfirmAccountStatus.ConfirmRequested));
  }

  Future handleConfirmAccountEvent(Emitter<ConfirmAccountState> emit) async {
    emit(state.CopyWith(status: ConfirmAccountStatus.Confirming));
    try {
        LoginUserResponse response = await accountRepository.confirmAccount(
        ConfirmAccountRequest(state.Email, state.ConfirmationCode)
      );

      if(!response.Success){
        emit(state.CopyWith(errorMessage: response.Message ?? 'Unknown Error', status: ConfirmAccountStatus.Error));
        return;
      }

      emit(state.CopyWith(status: ConfirmAccountStatus.Confirmed, login: response));
    }
    on Exception catch (e) {
      emit(state.CopyWith(errorMessage: e.toString(), status: ConfirmAccountStatus.Error));
    }
  }

  Future handleRedirectToHomeEvent(Emitter<ConfirmAccountState> emit) async {
    emit(state.CopyWith(status: ConfirmAccountStatus.RedirectToHome));
  }

  Future handleResendRequested(Emitter<ConfirmAccountState> emit) async {
    emit(state.CopyWith(status: ConfirmAccountStatus.Resending));
    try {
      BoolResponse response = await accountRepository.resendConfirmationCode(
          ResendConfirmationCodeRequest(state.Email)
      );

      if(!response.Success){
        emit(state.CopyWith(errorMessage: response.Message ?? 'Unknown Error', status: ConfirmAccountStatus.Error));
        return;
      }

      emit(state.CopyWith(status: ConfirmAccountStatus.Resent));
    }
    on Exception catch (e) {
      emit(state.CopyWith(errorMessage: "Failed to resend request", status: ConfirmAccountStatus.Error));
    }
  }

}
