import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';

abstract class PreferencesEvent {}

class Initialized extends PreferencesEvent{}

class PreferenceToggled extends PreferencesEvent {
  PreferenceChip preferenceChip;

  PreferenceToggled(this.preferenceChip);
}