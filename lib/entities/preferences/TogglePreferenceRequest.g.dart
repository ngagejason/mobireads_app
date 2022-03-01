// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TogglePreferenceRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TogglePreferenceRequest _$TogglePreferenceRequestFromJson(
        Map<String, dynamic> json) =>
    TogglePreferenceRequest(
      json['id'] as String,
      json['isSelected'] as bool,
    );

Map<String, dynamic> _$TogglePreferenceRequestToJson(
        TogglePreferenceRequest instance) =>
    <String, dynamic>{
      'id': instance.Id,
      'isSelected': instance.IsSelected,
    };
