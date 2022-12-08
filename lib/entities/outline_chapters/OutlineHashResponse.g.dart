// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OutlineHashResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutlineHashResponse _$OutlineHashResponseFromJson(Map<String, dynamic> json) =>
    OutlineHashResponse(
      (json['outlineHashes'] as List<dynamic>)
          .map((e) => OutlineHash.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OutlineHashResponseToJson(
        OutlineHashResponse instance) =>
    <String, dynamic>{
      'outlineHashes': instance.OutlineHashes,
    };
