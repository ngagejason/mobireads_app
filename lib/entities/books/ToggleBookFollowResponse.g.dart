// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ToggleBookFollowResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToggleBookFollowResponse _$ToggleBookFollowResponseFromJson(
        Map<String, dynamic> json) =>
    ToggleBookFollowResponse(
      json['doesFollow'] as bool,
      json['success'] as bool,
      json['message'] as String?,
    );

Map<String, dynamic> _$ToggleBookFollowResponseToJson(
        ToggleBookFollowResponse instance) =>
    <String, dynamic>{
      'doesFollow': instance.DoesFollow,
      'success': instance.Success,
      'message': instance.Message,
    };
