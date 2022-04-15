import 'package:mobi_reads/entities/preferences/Preference.dart';

abstract class PreferencesEvent {}

class InitializePreferences extends PreferencesEvent{}

class Loaded extends PreferencesEvent{}

class PreferenceToggled extends PreferencesEvent {
  Preference preference;
  List<void Function()>? functions;

  PreferenceToggled(this.preference, { this.functions });
}