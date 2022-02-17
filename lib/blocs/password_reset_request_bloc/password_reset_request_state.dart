import 'package:email_validator/email_validator.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';

enum PasswordResetRequestStatus {
  UserInput,
  EmailRequested,
  SendingEmail,
  EmailSent,
  Error,
  RedirectToConfirm
}

class PasswordResetRequestState {

  final String Email;
  final PasswordResetRequestStatus Status;
  final RegExp Regex = RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$");
  final String ErrorMessage;
  final LoginUserResponse? Login;

  bool get IsEmailValid => isEmailValid();
  bool get IsReadyToSubmit => IsEmailValid;

  bool isEmailValid(){
    if(Status != PasswordResetRequestStatus.EmailRequested){
      return true;
    }

    return EmailValidator.validate(Email);
  }

  PasswordResetRequestState ({
    this.Email = '',
    this.Status = PasswordResetRequestStatus.UserInput,
    this.ErrorMessage = 'Unknown Error',
    this.Login
  });

  PasswordResetRequestState CopyWith(
      {
        String? email,
        String? password,
        PasswordResetRequestStatus? status,
        String? errorMessage,
        LoginUserResponse? login
      }) {
    return PasswordResetRequestState(
        Email: email ?? this.Email,
        Status: status ?? this.Status,
        ErrorMessage: errorMessage ?? this.ErrorMessage,
        Login: login ?? this.Login
    );
  }
}