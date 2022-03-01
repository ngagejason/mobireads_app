
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_event.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_state.dart';
import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';
import 'package:mobi_reads/entities/preferences/PreferencesResponse.dart';
import 'package:mobi_reads/entities/preferences/TogglePreferenceRequest.dart';
import 'package:mobi_reads/repositories/preferences_repository.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {

  PreferencesRepository preferencesRepository;

  PreferencesBloc(this.preferencesRepository) : super(PreferencesState()){
    on<Initialized>((event, emit) async => await handleInitializedEvent(event, emit));
    on<PreferenceToggled>((event, emit) async => await handlePreferenceToggledEvent(event, emit));
  }

  Future handleInitializedEvent(Initialized event, Emitter<PreferencesState> emit) async {
    PreferencesResponse response = await preferencesRepository.getUserPreferences();
    emit(state.CopyWith(preferenceChips: response.PreferenceChips, status: PreferencesStatus.Loaded));
  }

  Future handlePreferenceToggledEvent(PreferenceToggled event, Emitter<PreferencesState> emit) async {
    PreferenceChip data = event.preferenceChip;
    await preferencesRepository.togglePreference(TogglePreferenceRequest(data.Id, data.IsSelected));
    data.IsSelected = !data.IsSelected;
    emit(state.CopyWith(preferenceChips: state.PreferenceChips));
  }
}