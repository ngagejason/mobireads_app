// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preference _$PreferenceFromJson(Map<String, dynamic> json) => Preference(
      json['id'] as String,
      json['context'] as String,
      json['label'] as String,
      json['isSelected'] as bool,
      json['code'] as int,
      json['isVisible'] as bool,
    );

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'id': instance.Id,
      'context': instance.Context,
      'label': instance.Label,
      'isSelected': instance.IsSelected,
      'code': instance.Code,
      'isVisible': instance.IsVisible,
    };
