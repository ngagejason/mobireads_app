// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginUserRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserRequest _$LoginUserRequestFromJson(Map<String, dynamic> json) =>
    LoginUserRequest(
      json['email'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$LoginUserRequestToJson(LoginUserRequest instance) =>
    <String, dynamic>{
      'email': instance.Email,
      'password': instance.Password,
    };
