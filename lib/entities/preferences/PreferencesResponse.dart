import 'package:json_annotation/json_annotation.dart';
import 'package:mobi_reads/entities/preferences/Preference.dart';

part 'PreferencesResponse.g.dart';

@JsonSerializable()
class PreferencesResponse {

  @JsonKey(name: 'preferences')
  List<Preference> Preferences;

  PreferencesResponse(this.Preferences);

  factory PreferencesResponse.fromJson(Map<String, dynamic> json) => _$PreferencesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PreferencesResponseToJson(this);
}