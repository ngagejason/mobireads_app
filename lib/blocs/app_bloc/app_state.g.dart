// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
      json['Id'] as String,
      Email: json['Email'] as String? ?? '',
      Username: json['Username'] as String? ?? '',
      Status: $enumDecodeNullable(_$AppStatusEnumMap, json['Status']) ??
          AppStatus.Initializing,
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'Id': instance.Id,
      'Email': instance.Email,
      'Username': instance.Username,
      'Status': _$AppStatusEnumMap[instance.Status],
    };

const _$AppStatusEnumMap = {
  AppStatus.Initializing: 'Initializing',
  AppStatus.LoggedIn: 'LoggedIn',
  AppStatus.LoggedOut: 'LoggedOut',
};
