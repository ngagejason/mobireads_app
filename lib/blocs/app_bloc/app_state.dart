import 'package:json_annotation/json_annotation.dart';

part 'app_state.g.dart';

enum AppStatus {
  Initializing,
  Initialized,
  LoggedIn,
  LoggedOut
}

@JsonSerializable()
class AppState {

  final bool IsGuest;
  final String Id;
  final String Email;
  final String Username;
  final String Bearer;
  final AppStatus Status;
  final String CurrentBook;

  AppState (
    this.Id, {
    this.IsGuest = true,
    this.Email = '',
    this.Username = '',
    this.Bearer = '',
    this.Status = AppStatus.Initializing,
    this.CurrentBook = ''
  });

  AppState CopyWith(
      String id,
      {
        bool? isGuest,
        String? email,
        String? username,
        String? bearer,
        AppStatus? status,
        String? currentBook,
      }) {
    return AppState(
        id,
        IsGuest: isGuest ?? this.IsGuest,
        Email: email ?? this.Email,
        Username: username ?? this.Username,
        Bearer: bearer ?? this.Bearer,
        Status: status ?? this.Status,
        CurrentBook: currentBook ?? this.CurrentBook
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}