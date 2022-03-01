// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
      json['Id'] as String,
      IsGuest: json['IsGuest'] as bool? ?? true,
      Email: json['Email'] as String? ?? '',
      Username: json['Username'] as String? ?? '',
      Bearer: json['Bearer'] as String? ?? '',
      Status: $enumDecodeNullable(_$AppStatusEnumMap, json['Status']) ??
          AppStatus.Initializing,
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'IsGuest': instance.IsGuest,
      'Id': instance.Id,
      'Email': instance.Email,
      'Username': instance.Username,
      'Bearer': instance.Bearer,
      'Status': _$AppStatusEnumMap[instance.Status],
    };

const _$AppStatusEnumMap = {
  AppStatus.Initializing: 'Initializing',
  AppStatus.Initialized: 'Initialized',
  AppStatus.LoggedIn: 'LoggedIn',
  AppStatus.LoggedOut: 'LoggedOut',
};
