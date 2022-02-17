// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountRequest _$CreateAccountRequestFromJson(Map<String, dynamic> json) {
  return CreateAccountRequest(
    json['email'] as String,
    json['username'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$CreateAccountRequestToJson(
        CreateAccountRequest instance) =>
    <String, dynamic>{
      'email': instance.Email,
      'username': instance.Username,
      'password': instance.Password,
    };
