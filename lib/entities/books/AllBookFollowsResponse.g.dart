// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllBookFollowsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllBookFollowsResponse _$AllBookFollowsResponseFromJson(
        Map<String, dynamic> json) =>
    AllBookFollowsResponse(
      (json['followedBooks'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllBookFollowsResponseToJson(
        AllBookFollowsResponse instance) =>
    <String, dynamic>{
      'followedBooks': instance.FollowedBooks,
    };
