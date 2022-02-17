// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bool_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoolResponse _$BoolResponseFromJson(Map<String, dynamic> json) {
  return BoolResponse(
    json['success'] as bool,
    json['message'] as String?,
  );
}

Map<String, dynamic> _$BoolResponseToJson(BoolResponse instance) =>
    <String, dynamic>{
      'success': instance.Success,
      'message': instance.Message,
    };
