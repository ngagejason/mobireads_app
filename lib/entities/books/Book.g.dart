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
      json['backCoverImageUrl'] as String?,
      json['wordCount'] as int,
      json['authorFirstName'] as String,
      json['authorLastName'] as String,
      json['authorMiddleName'] as String?,
      json['genreCode'] as int,
      json['genreName'] as String,
      json['followCount'] as int,
      json['summary'] as String,
      (json['additionalImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['pubType'] as int,
      json['seriesId'] as String?,
      json['seriesTitle'] as String,
      json['seriesSubtitle'] as String,
      json['bookNumberInSeries'] as int,
      json['bookCountInSeries'] as int,
      (json['seriesFrontCoverUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['version'] as int,
      json['status'] as int,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.Id,
      'genreId': instance.GenreId,
      'title': instance.Title,
      'subtitle': instance.Subtitle,
      'frontCoverImageUrl': instance.FrontCoverImageUrl,
      'backCoverImageUrl': instance.BackCoverImageUrl,
      'wordCount': instance.WordCount,
      'authorFirstName': instance.AuthorFirstName,
      'authorLastName': instance.AuthorLastName,
      'authorMiddleName': instance.AuthorMiddleName,
      'genreCode': instance.GenreCode,
      'genreName': instance.GenreName,
      'followCount': instance.FollowCount,
      'summary': instance.Summary,
      'additionalImages': instance.AdditionalImages,
      'pubType': instance.PubType,
      'seriesId': instance.SeriesId,
      'seriesTitle': instance.SeriesTitle,
      'seriesSubtitle': instance.SeriesSubtitle,
      'bookNumberInSeries': instance.BookNumberInSeries,
      'bookCountInSeries': instance.BookCountInSeries,
      'seriesFrontCoverUrls': instance.SeriesFrontCoverUrls,
      'version': instance.Version,
      'status': instance.Status,
    };
