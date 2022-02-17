// ignore_for_file: non_constant_identifier_names

import 'package:email_validator/email_validator.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';

enum ConfirmAccountStatus {
  UserInput,
  ComfirmRequested,
  Confirming,
  Confirmed,
  Error,
  RedirectToHome
}

class ConfirmAccountState {

  final String Email;
  final String ConfirmationCode;
  final String ErrorMessage;
  final ConfirmAccountStatus Status;
  final LoginUserResponse? Login;

  bool get IsEmailValid => isEmailValid();
  bool get IsConfirmationCodeValid => isConfirmationCodeValid();
  bool get IsReadyToSubmit => IsEmailValid && isConfirmationCodeValid();

  bool isEmailValid(){
    if(Status != ConfirmAccountStatus.ComfirmRequested){
      return true;
    }

    return EmailValidator.validate(Email);
  }

  bool isConfirmationCodeValid(){
    if(Status != ConfirmAccountStatus.ComfirmRequested){
      return true;
    }

    return this.ConfirmationCode != '' && this.ConfirmationCode.length > 1;
  }

  ConfirmAccountState ({
    this.Email = '',
    this.ConfirmationCode = '',
    this.Status = ConfirmAccountStatus.UserInput,
    this.ErrorMessage = 'Unknown Error',
    this.Login
  });

  ConfirmAccountState CopyWith(
      {
        String? email,
        String? confirmationCode,
        ConfirmAccountStatus? status,
        String? errorMessage,
        LoginUserResponse? login
      }) {
    return ConfirmAccountState(
        Email: email ?? this.Email,
        ConfirmationCode: confirmationCode ?? this.ConfirmationCode,
        Status: status ?? this.Status,
        ErrorMessage: errorMessage ?? this.ErrorMessage,
        Login: login ?? this.Login
    );
  }
}