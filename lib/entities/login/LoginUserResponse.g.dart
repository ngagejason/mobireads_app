// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginUserResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserResponse _$LoginUserResponseFromJson(Map<String, dynamic> json) =>
    LoginUserResponse(
      json['id'] as String,
      json['email'] as String,
      json['username'] as String,
      json['bearer'] as String,
      json['success'] as bool,
      json['message'] as String?,
      json['isGuest'] as bool,
    );

Map<String, dynamic> _$LoginUserResponseToJson(LoginUserResponse instance) =>
    <String, dynamic>{
      'id': instance.Id,
      'email': instance.Email,
      'username': instance.Username,
      'bearer': instance.Bearer,
      'success': instance.Success,
      'message': instance.Message,
      'isGuest': instance.IsGuest,
    };
