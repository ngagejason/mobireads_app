import 'package:email_validator/email_validator.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';

enum LoginStatus {
  UserInput,
  LoginRequested,
  LoggingIn,
  LoggedIn,
  Error,
  RedirectToHome
}

class LoginState {

  final String Email;
  final String Password;
  final LoginStatus Status;
  final RegExp Regex = RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$");
  final String ErrorMessage;
  final LoginUserResponse? Login;

  bool get IsEmailValid => isEmailValid();
  bool get IsPasswordValid => isPasswordValid();
  bool get IsReadyToSubmit => IsEmailValid && IsPasswordValid;

  bool isEmailValid(){
    if(Status != LoginStatus.LoginRequested){
      return true;
    }

    return EmailValidator.validate(Email);
  }

  bool isPasswordValid(){
    if(Status != LoginStatus.LoginRequested){
      return true;
    }

    return Regex.hasMatch(Password);
  }

  LoginState ({
    this.Email = '',
    this.Password = '',
    this.Status = LoginStatus.UserInput,
    this.ErrorMessage = 'Unknown Error',
    this.Login
  });

  LoginState CopyWith(
      {
        String? email,
        String? password,
        LoginStatus? status,
        String? errorMessage,
        LoginUserResponse? login
      }) {
    return LoginState(
        Email: email ?? this.Email,
        Password: password ?? this.Password,
        Status: status ?? this.Status,
        ErrorMessage: errorMessage ?? this.ErrorMessage,
        Login: login ?? this.Login
    );
  }
}