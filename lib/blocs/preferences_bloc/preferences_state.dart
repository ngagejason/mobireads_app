

import 'package:mobi_reads/entities/preferences/Preference.dart';

enum PreferencesStatus {
  Constructed,
  PreferencesLoading,
  PreferencesLoaded,
  Loaded,
  Error
}

class PreferencesState {

  final List<Preference> Preferences;
  final PreferencesStatus Status;

  PreferencesState({this.Preferences = const [], this.Status = PreferencesStatus.Constructed});

  PreferencesState CopyWith(
      {
        PreferencesStatus? status,
        List<Preference>? preferences
      }) {
    return PreferencesState(
      Status: status ?? this.Status,
      Preferences: preferences ?? this.Preferences
    );
  }
}