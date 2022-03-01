// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestResult<T> _$RequestResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    RequestResult<T>(
      json['success'] as bool? ?? false,
      json['message'] as String?,
      _$nullableGenericFromJson(json['data'], fromJsonT),
      json['redirect'] as String?,
    );

Map<String, dynamic> _$RequestResultToJson<T>(
  RequestResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.Success,
      'message': instance.Message,
      'data': _$nullableGenericToJson(instance.Data, toJsonT),
      'redirect': instance.Redirect,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
