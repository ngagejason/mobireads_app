// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrendingBooksResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingBooksResponse _$TrendingBooksResponseFromJson(
        Map<String, dynamic> json) =>
    TrendingBooksResponse(
      (json['books'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['displayType'] as int,
    );

Map<String, dynamic> _$TrendingBooksResponseToJson(
        TrendingBooksResponse instance) =>
    <String, dynamic>{
      'displayType': instance.DisplayType,
      'books': instance.Books,
    };
