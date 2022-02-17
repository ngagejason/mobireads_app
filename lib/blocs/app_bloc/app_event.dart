abstract class AppEvent {}

class UserLoggedInEvent extends AppEvent {
  String id;
  String email;
  String username;
  String bearer;
  bool isGuest;

  UserLoggedInEvent(this.id, this.email, this.username, this.bearer, this.isGuest);
}

class UserLoggedOutEvent extends AppEvent {}

class AppInitializedEvent extends AppEvent {}

class AppInitializingEvent extends AppEvent {}
