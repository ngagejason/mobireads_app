// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Peek.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Peek _$PeekFromJson(Map<String, dynamic> json) => Peek(
      json['title'] as String,
      json['author'] as String,
      json['genre'] as String,
      json['frontCoverImageUrl'] as String,
      json['followCount'] as int,
      json['summary'] as String,
      json['bookId'] as String,
      json['doesFollow'] as bool,
    );

Map<String, dynamic> _$PeekToJson(Peek instance) => <String, dynamic>{
      'title': instance.Title,
      'author': instance.Author,
      'genre': instance.Genre,
      'frontCoverImageUrl': instance.FrontCoverImageUrl,
      'followCount': instance.FollowCount,
      'summary': instance.Summary,
      'bookId': instance.BookId,
      'doesFollow': instance.DoesFollow,
    };
