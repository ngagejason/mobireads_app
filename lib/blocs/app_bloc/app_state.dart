import 'package:json_annotation/json_annotation.dart';

part 'app_state.g.dart';

enum AppStatus {
  Initializing,
  LoggedIn,
  LoggedOut
}

@JsonSerializable()
class AppState {

  final String Id;
  final String Email;
  final String Username;
  final AppStatus Status;

  AppState (
    this.Id, {
    this.Email = '',
    this.Username = '',
    this.Status = AppStatus.Initializing
  });

  AppState CopyWith(
      String id,
      {
        String? email,
        String? username,
        AppStatus? status
      }) {
    return AppState(
        id,
        Email: email ?? this.Email,
        Username: username ?? this.Username,
        Status: status ?? this.Status
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}