// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      json['id'] as String,
      json['title'] as String?,
      json['subtitle'] as String?,
      json['frontCoverImageUrl'] as String?,
      json['frontCoverImageMimeType'] as String?,
      json['backCoverImageUrl'] as String?,
      json['backCoverImageMimeType'] as String?,
      json['authorFirstName'] as String?,
      json['authorMiddleName'] as String?,
      json['authorLastName'] as String?,
      json['summary'] as String?,
      json['status'] as int,
      json['version'] as int,
      json['wordCount'] as int,
      json['chapterCount'] as int,
      json['followCount'] as int?,
      (json['preferences'] as List<dynamic>)
          .map((e) => Preference.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.Id,
      'title': instance.Title,
      'subtitle': instance.Subtitle,
      'frontCoverImageUrl': instance.FrontCoverImageUrl,
      'frontCoverImageMimeType': instance.FrontCoverImageMimeType,
      'backCoverImageUrl': instance.BackCoverImageUrl,
      'backCoverImageMimeType': instance.BackCoverImageMimeType,
      'authorFirstName': instance.AuthorFirstName,
      'authorMiddleName': instance.AuthorMiddleName,
      'authorLastName': instance.AuthorLastName,
      'summary': instance.Summary,
      'status': instance.Status,
      'version': instance.Version,
      'wordCount': instance.WordCount,
      'chapterCount': instance.ChapterCount,
      'followCount': instance.FollowCount,
      'preferences': instance.Preferences,
    };
