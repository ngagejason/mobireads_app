// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PreferenceChip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferenceChip _$PreferenceChipFromJson(Map<String, dynamic> json) =>
    PreferenceChip(
      json['id'] as String,
      json['context'] as String,
      json['label'] as String,
      json['isSelected'] as bool,
      json['code'] as int,
    );

Map<String, dynamic> _$PreferenceChipToJson(PreferenceChip instance) =>
    <String, dynamic>{
      'id': instance.Id,
      'context': instance.Context,
      'label': instance.Label,
      'isSelected': instance.IsSelected,
      'code': instance.Code,
    };
