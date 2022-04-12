// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SeriesDetailsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesDetailsResponse _$SeriesDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    SeriesDetailsResponse(
      json['id'] as String,
      json['title'] as String,
      json['subtitle'] as String,
      json['bookCountInSeries'] as int,
      json['genreId'] as String,
      json['genreCode'] as int,
      json['genreName'] as String,
      json['summary'] as String,
      (json['books'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeriesDetailsResponseToJson(
        SeriesDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.Id,
      'title': instance.Title,
      'subtitle': instance.Subtitle,
      'bookCountInSeries': instance.BookCountInSeries,
      'genreId': instance.GenreId,
      'genreCode': instance.GenreCode,
      'genreName': instance.GenreName,
      'summary': instance.Summary,
      'books': instance.Books,
    };
