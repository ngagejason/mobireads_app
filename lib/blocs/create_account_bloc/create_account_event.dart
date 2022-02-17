abstract class CreateAccountEvent {}

class EmailChanged extends CreateAccountEvent {
  String email;
  EmailChanged(this.email);
}

class UsernameChanged extends CreateAccountEvent {
  String username;
  UsernameChanged(this.username);
}

class PasswordChanged extends CreateAccountEvent {
  String password;
  PasswordChanged(this.password);
}

class CreateAccountRequested extends CreateAccountEvent {}

class CreateAccount extends CreateAccountEvent {}
