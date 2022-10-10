// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeleteBookNoteRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteBookNoteRequest _$DeleteBookNoteRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteBookNoteRequest(
      json['id'] as String,
      json['bookId'] as String,
    );

Map<String, dynamic> _$DeleteBookNoteRequestToJson(
        DeleteBookNoteRequest instance) =>
    <String, dynamic>{
      'id': instance.Id,
      'bookId': instance.BookId,
    };
