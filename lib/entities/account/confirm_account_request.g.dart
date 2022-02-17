// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmAccountRequest _$ConfirmAccountRequestFromJson(
    Map<String, dynamic> json) {
  return ConfirmAccountRequest(
    json['email'] as String,
    json['confirmationCode'] as String,
  );
}

Map<String, dynamic> _$ConfirmAccountRequestToJson(
        ConfirmAccountRequest instance) =>
    <String, dynamic>{
      'email': instance.Email,
      'confirmationCode': instance.ConfirmationCode,
    };
