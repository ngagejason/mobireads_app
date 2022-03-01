

import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';

enum PreferencesStatus {
  Loading,
  Loaded,
  Error
}

class PreferencesState {

  final List<PreferenceChip> PreferenceChips;
  final PreferencesStatus Status;

  PreferencesState({this.PreferenceChips = const [], this.Status = PreferencesStatus.Loading});

  PreferencesState CopyWith(
      {
        PreferencesStatus? status,
        List<PreferenceChip>? preferenceChips
      }) {
    return PreferencesState(
      Status: status ?? this.Status,
      PreferenceChips: preferenceChips ?? this.PreferenceChips
    );
  }
}