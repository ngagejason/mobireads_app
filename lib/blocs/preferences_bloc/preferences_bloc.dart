
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_event.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_state.dart';
import 'package:mobi_reads/entities/preferences/Preference.dart';
import 'package:mobi_reads/entities/preferences/PreferencesResponse.dart';
import 'package:mobi_reads/entities/preferences/TogglePreferenceRequest.dart';
import 'package:mobi_reads/repositories/preferences_repository.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {

  PreferencesRepository preferencesRepository;

  PreferencesBloc(this.preferencesRepository) : super(PreferencesState()){
    on<InitializePreferences>((event, emit) async => await handleInitializeEvent(event, emit));
    on<PreferenceToggled>((event, emit) async => await handlePreferenceToggledEvent(event, emit));
    on<Loaded>((event, emit) async => await handleLoadedEvent(event, emit));
  }

  Future handleInitializeEvent(InitializePreferences event, Emitter<PreferencesState> emit) async {
    emit(state.CopyWith(status: PreferencesStatus.PreferencesLoading));
    PreferencesResponse response = await preferencesRepository.getUserPreferences();
    emit(state.CopyWith(preferences: response.Preferences, status: PreferencesStatus.PreferencesLoaded));
  }

  Future handleLoadedEvent(Loaded event, Emitter<PreferencesState> emit) async {
    emit(state.CopyWith(status: PreferencesStatus.Loaded));
  }

  Future handlePreferenceToggledEvent(PreferenceToggled event, Emitter<PreferencesState> emit) async {
    Preference data = event.preference;
    data.IsSelected = !data.IsSelected;
    emit(state.CopyWith(preferences: state.Preferences));
    await preferencesRepository.togglePreference(TogglePreferenceRequest(data.Id, !data.IsSelected));
    emit(state.CopyWith(preferences: state.Preferences));
    if(event.functions != null){
      event.functions!.forEach((element) {element();});
    }
  }
}
