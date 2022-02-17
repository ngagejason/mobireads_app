// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    json['Id'] as String,
    IsLoggedIn: json['IsLoggedIn'] as bool,
    IsGuest: json['IsGuest'] as bool,
    Email: json['Email'] as String,
    Username: json['Username'] as String,
    Bearer: json['Bearer'] as String,
    Status: _$enumDecode(_$AppStatusEnumMap, json['Status']),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'IsLoggedIn': instance.IsLoggedIn,
      'IsGuest': instance.IsGuest,
      'Id': instance.Id,
      'Email': instance.Email,
      'Username': instance.Username,
      'Bearer': instance.Bearer,
      'Status': _$AppStatusEnumMap[instance.Status],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$AppStatusEnumMap = {
  AppStatus.Initializing: 'Initializing',
  AppStatus.Initialized: 'Initialized',
};
