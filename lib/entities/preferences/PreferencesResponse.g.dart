// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PreferencesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferencesResponse _$PreferencesResponseFromJson(Map<String, dynamic> json) =>
    PreferencesResponse(
      (json['preferenceChips'] as List<dynamic>)
          .map((e) => PreferenceChip.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PreferencesResponseToJson(
        PreferencesResponse instance) =>
    <String, dynamic>{
      'preferenceChips': instance.PreferenceChips,
    };
