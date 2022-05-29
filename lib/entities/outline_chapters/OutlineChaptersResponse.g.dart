// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OutlineChaptersResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutlineChaptersResponse _$OutlineChaptersResponseFromJson(
        Map<String, dynamic> json) =>
    OutlineChaptersResponse(
      (json['chapters'] as List<dynamic>)
          .map((e) => OutlineChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OutlineChaptersResponseToJson(
        OutlineChaptersResponse instance) =>
    <String, dynamic>{
      'chapters': instance.Chapters,
    };
