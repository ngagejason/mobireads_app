import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/create_account_bloc/create_account_event.dart';
import 'package:mobi_reads/entities/account/create_account_request.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/repositories/account_repository.dart';
import 'create_account_state.dart';


class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {

  AccountRepository accountRepository;

  CreateAccountBloc(this.accountRepository) : super(CreateAccountState()){
    on<EmailChanged>((event, emit) async => await handleEmailChangedEvent(event, emit));
    on<UsernameChanged>((event, emit) async => await handleUsernameChangedEvent(event, emit));
    on<PasswordChanged>((event, emit) async => await handlePasswordChangedEvent(event, emit));
    on<CreateAccountRequested>((event, emit) async => await handleCreateAccountRequestedEvent(emit));
    on<CreateAccount>((event, emit) async => await handleCreateAccountEvent(emit));
  }

  Future handleEmailChangedEvent(EmailChanged event, Emitter<CreateAccountState> emit) async {
    emit(state.CopyWith(email: event.email, status: CreateAccountStatus.UserInput));
  }

  Future handleUsernameChangedEvent(UsernameChanged event, Emitter<CreateAccountState> emit) async {
    try {
      if(event.username != state.Username){
        emit(state.CopyWith(username: event.username, usernameConfirmed: false, usernameNotAvailable: false, status: CreateAccountStatus.UserInput));
        if(event.username.length > 3){
          emit(state.CopyWith(status: CreateAccountStatus.CheckingUserName));
          BoolResponse isAvailable = await accountRepository.checkAvailability(event.username);
          if(isAvailable.Success){
            emit(state.CopyWith(username: event.username, usernameConfirmed: true, usernameNotAvailable: false, status: CreateAccountStatus.UserInput));
          }
          else{
            emit(state.CopyWith(username: event.username, usernameConfirmed: false, usernameNotAvailable: true, status: CreateAccountStatus.UserInput));
          }
        }
      }
    } on Exception catch (e) {
      emit(state.CopyWith(errorMessage: e.toString(), status: CreateAccountStatus.Error));
    }
  }

  Future handlePasswordChangedEvent(PasswordChanged event, Emitter<CreateAccountState> emit) async {
    emit(state.CopyWith(password: event.password, status: CreateAccountStatus.UserInput));
  }

  Future handleCreateAccountRequestedEvent(Emitter<CreateAccountState> emit) async {
    emit(state.CopyWith(status: CreateAccountStatus.CreateRequested));
  }

  Future handleCreateAccountEvent(Emitter<CreateAccountState> emit) async {
    emit(state.CopyWith(status: CreateAccountStatus.Creating));
    try {
      BoolResponse response = await accountRepository.createAccount(
        CreateAccountRequest(state.Email, state.Username, state.Password)
      );

      if(!response.Success){
        emit(state.CopyWith(errorMessage: response.Message ?? 'Unknown Error', status: CreateAccountStatus.Error));
        return;
      }

      emit(state.CopyWith(status: CreateAccountStatus.Created));
    }
    on Exception catch (e) {
      emit(state.CopyWith(errorMessage: e.toString(), status: CreateAccountStatus.Error));
    }
  }
}
