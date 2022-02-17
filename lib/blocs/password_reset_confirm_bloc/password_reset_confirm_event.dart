abstract class PasswordResetConfirmEvent {}

class PasswordChanged extends PasswordResetConfirmEvent {
  String password;
  PasswordChanged(this.password);
}

class ConfirmationCodeChanged extends PasswordResetConfirmEvent {
  String confirmationCode;
  ConfirmationCodeChanged(this.confirmationCode);
}

class ConfirmRequested extends PasswordResetConfirmEvent {}

class Confirm extends PasswordResetConfirmEvent {}

class RedirectToHome extends PasswordResetConfirmEvent {}