// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PeekResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeekResponse _$PeekResponseFromJson(Map<String, dynamic> json) => PeekResponse(
      (json['peeks'] as List<dynamic>?)
          ?.map((e) => Peek.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['displayType'] as int,
    );

Map<String, dynamic> _$PeekResponseToJson(PeekResponse instance) =>
    <String, dynamic>{
      'displayType': instance.DisplayType,
      'peeks': instance.Peeks,
    };
