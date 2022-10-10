// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddBookNoteRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBookNoteRequest _$AddBookNoteRequestFromJson(Map<String, dynamic> json) =>
    AddBookNoteRequest(
      json['bookId'] as String,
      json['title'] as String,
      json['note'] as String,
    );

Map<String, dynamic> _$AddBookNoteRequestToJson(AddBookNoteRequest instance) =>
    <String, dynamic>{
      'bookId': instance.BookId,
      'title': instance.Title,
      'note': instance.Note,
    };
