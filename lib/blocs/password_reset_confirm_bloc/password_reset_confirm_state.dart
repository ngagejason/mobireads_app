import 'package:email_validator/email_validator.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';

enum PasswordResetConfirmStatus {
  UserInput,
  ConfirmRequested,
  SendingConfirm,
  Confirmed,
  Error,
  RedirectToHome
}

class PasswordResetConfirmState {

  final String Email;
  final String Password;
  final String ConfirmationCode;
  final PasswordResetConfirmStatus Status;
  final RegExp Regex = RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$");
  final String ErrorMessage;
  final LoginUserResponse? Login;

  bool get IsEmailValid => isEmailValid();
  bool get IsPasswordValid => isPasswordValid();
  bool get IsConfirmationCodeValid => isConfirmationCodeValid();


  bool isEmailValid(){
    if(Status != PasswordResetConfirmStatus.ConfirmRequested){
      return true;
    }

    return EmailValidator.validate(Email);
  }

  bool isPasswordValid(){
    if(Status != PasswordResetConfirmStatus.ConfirmRequested){
      return true;
    }

    return Regex.hasMatch(Password);
  }

  bool isConfirmationCodeValid(){
    if(Status != PasswordResetConfirmStatus.ConfirmRequested){
      return true;
    }

    return this.ConfirmationCode.trim().length > 0;
  }

  PasswordResetConfirmState (this.Email, {

    this.Password = '',
    this.ConfirmationCode = '',
    this.Status = PasswordResetConfirmStatus.UserInput,
    this.ErrorMessage = 'Unknown Error',
    this.Login
  });

  PasswordResetConfirmState CopyWith(
      {
        String? confirmationCode,
        String? password,
        PasswordResetConfirmStatus? status,
        String? errorMessage,
        LoginUserResponse? login
      }) {
    return PasswordResetConfirmState(
        this.Email,
        Password: password ?? this.Password,
        ConfirmationCode: confirmationCode ?? this.ConfirmationCode,
        Status: status ?? this.Status,
        ErrorMessage: errorMessage ?? this.ErrorMessage,
        Login: login ?? this.Login
    );
  }
}