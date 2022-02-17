import 'package:json_annotation/json_annotation.dart';

part 'app_state.g.dart';

enum AppStatus {
  Initializing,
  Initialized,
  LoggedOut
}

@JsonSerializable()
class AppState {

  final bool IsLoggedIn;
  final bool IsGuest;
  final String Id;
  final String Email;
  final String Username;
  final String Bearer;
  final AppStatus Status;

  AppState (
    this.Id, {
    this.IsLoggedIn = false,
    this.IsGuest = true,
    this.Email = '',
    this.Username = '',
    this.Bearer = '',
    this.Status = AppStatus.Initializing
  });

  AppState CopyWith(
      String id,
      {
        bool? isLoggedIn,
        bool? isGuest,
        String? email,
        String? username,
        String? bearer,
        AppStatus? status
      }) {
    return AppState(
        id,
        IsLoggedIn: isLoggedIn ?? this.IsLoggedIn,
        IsGuest: isGuest ?? this.IsGuest,
        Email: email ?? this.Email,
        Username: username ?? this.Username,
        Bearer: bearer ?? this.Bearer,
        Status: status ?? this.Status
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}