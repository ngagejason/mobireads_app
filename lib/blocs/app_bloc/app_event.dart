abstract class AppEvent {}

class UserLoggedInEvent extends AppEvent {
  String id;
  String email;
  String username;

  UserLoggedInEvent(this.id, this.email, this.username);
}

class UserLoggedOutEvent extends AppEvent {}
