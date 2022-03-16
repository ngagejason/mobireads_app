// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      json['id'] as String,
      json['genreId'] as String,
      json['title'] as String,
      json['subtitle'] as String,
      json['frontCoverImageUrl'] as String,
      json['wordCount'] as int,
      json['authorFirstName'] as String,
      json['authorLastName'] as String,
      json['authorMiddleName'] as String,
      json['genreCode'] as int,
      json['genreName'] as String,
      json['followCount'] as int,
      json['summary'] as String,
      json['doesFollow'] as bool,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.Id,
      'genreId': instance.GenreId,
      'title': instance.Title,
      'subtitle': instance.Subtitle,
      'frontCoverImageUrl': instance.FrontCoverImageUrl,
      'wordCount': instance.WordCount,
      'authorFirstName': instance.AuthorFirstName,
      'authorLastName': instance.AuthorLastName,
      'authorMiddleName': instance.AuthorMiddleName,
      'genreCode': instance.GenreCode,
      'genreName': instance.GenreName,
      'followCount': instance.FollowCount,
      'summary': instance.Summary,
      'doesFollow': instance.DoesFollow,
    };
