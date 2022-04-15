// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PreferencesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferencesResponse _$PreferencesResponseFromJson(Map<String, dynamic> json) =>
    PreferencesResponse(
      (json['preferences'] as List<dynamic>)
          .map((e) => Preference.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PreferencesResponseToJson(
        PreferencesResponse instance) =>
    <String, dynamic>{
      'preferences': instance.Preferences,
    };
