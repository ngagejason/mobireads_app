// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventLogRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventLogRequest _$EventLogRequestFromJson(Map<String, dynamic> json) =>
    EventLogRequest(
      json['logType'] as int,
      json['className'] as String,
      json['methodName'] as String,
      json['message'] as String,
    );

Map<String, dynamic> _$EventLogRequestToJson(EventLogRequest instance) =>
    <String, dynamic>{
      'logType': instance.LogType,
      'className': instance.ClassName,
      'methodName': instance.MethodName,
      'message': instance.Message,
    };
