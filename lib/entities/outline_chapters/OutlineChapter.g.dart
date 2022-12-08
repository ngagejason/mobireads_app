// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OutlineChapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutlineChapter _$OutlineChapterFromJson(Map<String, dynamic> json) =>
    OutlineChapter(
      json['id'] as String,
      json['title'] as String?,
      json['writing'] as String?,
      json['chapterNumber'] as int,
      json['deletedDateTimeUTC'] == null
          ? null
          : DateTime.parse(json['deletedDateTimeUTC'] as String),
      json['hash'] as String?,
    );

Map<String, dynamic> _$OutlineChapterToJson(OutlineChapter instance) =>
    <String, dynamic>{
      'id': instance.Id,
      'title': instance.Title,
      'writing': instance.Writing,
      'chapterNumber': instance.ChapterNumber,
      'deletedDateTimeUTC': instance.DeletedDateTimeUTC?.toIso8601String(),
      'hash': instance.Hash,
    };
