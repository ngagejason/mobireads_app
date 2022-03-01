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
    );

Map<String, dynamic> _$PeekToJson(Peek instance) => <String, dynamic>{
      'title': instance.Title,
      'author': instance.Author,
      'genre': instance.Genre,
      'frontCoverImageUrl': instance.FrontCoverImageUrl,
      'followCount': instance.FollowCount,
    };
