abstract class ConfirmAccountEvent {}

class EmailChanged extends ConfirmAccountEvent {
  String email;
  EmailChanged(this.email);
}

class ConfirmationCodeChanged extends ConfirmAccountEvent {
  String confirmationCode;
  ConfirmationCodeChanged(this.confirmationCode);
}

class ConfirmAccountRequested extends ConfirmAccountEvent {}

class ConfirmAccount extends ConfirmAccountEvent {}

class RedirectToHome extends ConfirmAccountEvent {}
