// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_confirm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordResetConfirm _$PasswordResetConfirmFromJson(Map<String, dynamic> json) {
  return PasswordResetConfirm(
    json['email'] as String,
    json['password'] as String,
    json['confirmationCode'] as String,
  );
}

Map<String, dynamic> _$PasswordResetConfirmToJson(
        PasswordResetConfirm instance) =>
    <String, dynamic>{
      'email': instance.Email,
      'confirmationCode': instance.ConfirmationCode,
      'password': instance.Password,
    };
