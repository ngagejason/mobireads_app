import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';

abstract class PreferencesEvent {}

class InitializePreferences extends PreferencesEvent{}

class Loaded extends PreferencesEvent{}

class PreferenceToggled extends PreferencesEvent {
  PreferenceChip preferenceChip;

  PreferenceToggled(this.preferenceChip);
}