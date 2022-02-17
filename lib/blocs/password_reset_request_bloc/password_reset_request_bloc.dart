import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/password_reset_request_bloc/password_reset_request_event.dart';
import 'package:mobi_reads/blocs/password_reset_request_bloc/password_reset_request_state.dart';
import 'package:mobi_reads/classes/ExceptionFormatter.dart';
import 'package:mobi_reads/entities/account/password_reset_request.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/repositories/account_repository.dart';


class PasswordResetRequestBloc extends Bloc<PasswordResetRequestEvent, PasswordResetRequestState> {

  AccountRepository accountRepository;

  PasswordResetRequestBloc(this.accountRepository) : super(PasswordResetRequestState()){
    on<EmailChanged>((event, emit) async => await handleEmailChangedEvent(event, emit));
    on<EmailRequested>((event, emit) async => await handleEmailRequestedEvent(emit));
    on<SendEmail>((event, emit) async => await handleSendEmailEvent(emit));
    on<RedirectToConfirm>((event, emit) async => await handleRedirectToConfirmEvent(emit));
  }

  Future handleEmailChangedEvent(EmailChanged event, Emitter<PasswordResetRequestState> emit) async {
    emit(state.CopyWith(email: event.email, status: PasswordResetRequestStatus.UserInput));
  }

  Future handleEmailRequestedEvent(Emitter<PasswordResetRequestState> emit) async {
    emit(state.CopyWith(status: PasswordResetRequestStatus.EmailRequested));
  }

  Future handleSendEmailEvent(Emitter<PasswordResetRequestState> emit) async {
    emit(state.CopyWith(status: PasswordResetRequestStatus.SendingEmail));
    try {
      BoolResponse response = await accountRepository.sendPasswordResetRequest(
        PasswordResetRequest(state.Email)
      );

      if(!response.Success){
        emit(state.CopyWith(errorMessage: response.Message ?? 'Unknown Error', status: PasswordResetRequestStatus.Error));
        return;
      }

      emit(state.CopyWith(status: PasswordResetRequestStatus.EmailSent));
    }
    on Exception catch (e) {
      emit(state.CopyWith(errorMessage: ExceptionFormatter.FormatException(e), status: PasswordResetRequestStatus.Error));
    }
  }

  Future handleRedirectToConfirmEvent(Emitter<PasswordResetRequestState> emit) async {
    emit(state.CopyWith(status: PasswordResetRequestStatus.RedirectToConfirm));
  }
}
