import 'package:email_validator/email_validator.dart';

enum CreateAccountStatus {
  UserInput,
  CreateRequested,
  Creating,
  Created,
  CheckingUserName,
  Error
}

class CreateAccountState {

  final String Email;
  final String Username;
  final String Password;
  final bool UsernameConfirmed;
  final bool UsernameNotAvailable;
  final CreateAccountStatus Status;
  final RegExp Regex = RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$");
  final String ErrorMessage;

  bool get IsEmailValid => isEmailValid();
  bool get IsPasswordValid => isPasswordValid();
  bool get IsUsernameValid => isUsernameValid();
  bool get IsReadyToSubmit => IsEmailValid && IsPasswordValid && IsUsernameValid;

  bool isEmailValid(){
    if(Status != CreateAccountStatus.CreateRequested){
      return true;
    }

    return EmailValidator.validate(Email);
  }

  bool isPasswordValid(){
    if(Status != CreateAccountStatus.CreateRequested){
      return true;
    }

    return Regex.hasMatch(Password);
  }

  bool isUsernameValid(){
    if(Status != CreateAccountStatus.CreateRequested){
      return true;
    }

    return UsernameConfirmed;
  }

  CreateAccountState ({
    this.Email = '',
    this.Username = '',
    this.Password = '',
    this.Status = CreateAccountStatus.UserInput,
    this.UsernameConfirmed = false,
    this.UsernameNotAvailable = false,
    this.ErrorMessage = 'Unknown Error'
  });

  CreateAccountState CopyWith(
      {
        String? email,
        String? username,
        String? password,
        CreateAccountStatus? status,
        bool? usernameConfirmed,
        bool? usernameNotAvailable,
        String? errorMessage
      }) {
    return CreateAccountState(
        Email: email ?? this.Email,
        Username: username ?? this.Username,
        Password: password ?? this.Password,
        Status: status ?? this.Status,
        UsernameConfirmed: usernameConfirmed ?? this.UsernameConfirmed,
        UsernameNotAvailable: usernameNotAvailable ?? this.UsernameNotAvailable,
        ErrorMessage: errorMessage ?? this.ErrorMessage
    );
  }
}