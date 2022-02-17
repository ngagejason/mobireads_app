abstract class PasswordResetRequestEvent {}

class EmailChanged extends PasswordResetRequestEvent {
  String email;
  EmailChanged(this.email);
}

class EmailRequested extends PasswordResetRequestEvent {}

class SendEmail extends PasswordResetRequestEvent {}

class RedirectToConfirm extends PasswordResetRequestEvent {}