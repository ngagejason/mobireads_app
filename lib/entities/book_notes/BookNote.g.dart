// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookNote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookNote _$BookNoteFromJson(Map<String, dynamic> json) => BookNote(
      json['id'] as String,
      json['title'] as String?,
      json['note'] as String?,
      DateTime.parse(json['createdDateTimeUTC'] as String),
    );

Map<String, dynamic> _$BookNoteToJson(BookNote instance) => <String, dynamic>{
      'id': instance.Id,
      'title': instance.Title,
      'note': instance.Note,
      'createdDateTimeUTC': instance.CreatedDateTimeUTC.toIso8601String(),
    };
