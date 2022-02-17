// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestResults.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestResults<T> _$RequestResultsFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return RequestResults<T>(
    json['success'] as bool? ?? false,
    json['message'] as String?,
    (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
    json['redirect'] as String?,
  );
}

Map<String, dynamic> _$RequestResultsToJson<T>(
  RequestResults<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.Success,
      'message': instance.Message,
      'data': instance.Data?.map(toJsonT).toList(),
      'redirect': instance.Redirect,
    };
