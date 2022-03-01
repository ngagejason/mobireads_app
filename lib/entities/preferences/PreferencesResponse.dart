import 'package:json_annotation/json_annotation.dart';
import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';

part 'PreferencesResponse.g.dart';

@JsonSerializable()
class PreferencesResponse {

  @JsonKey(name: 'preferenceChips')
  List<PreferenceChip> PreferenceChips;

  PreferencesResponse(this.PreferenceChips);

  factory PreferencesResponse.fromJson(Map<String, dynamic> json) => _$PreferencesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PreferencesResponseToJson(this);
}