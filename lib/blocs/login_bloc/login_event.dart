abstract class LoginEvent {}

class EmailChanged extends LoginEvent {
  String email;
  EmailChanged(this.email);
}

class PasswordChanged extends LoginEvent {
  String password;
  PasswordChanged(this.password);
}

class LoginRequested extends LoginEvent {}

class Login extends LoginEvent {}

class ContinueAsGuest extends LoginEvent {}