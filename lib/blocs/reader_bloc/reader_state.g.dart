// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReaderState _$ReaderStateFromJson(Map<String, dynamic> json) => ReaderState(
      status: $enumDecodeNullable(_$ReaderStatusEnumMap, json['status']) ??
          ReaderStatus.Constructed,
    )..allChapters = (json['allChapters'] as List<dynamic>)
        .map((e) => OutlineChapter.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ReaderStateToJson(ReaderState instance) =>
    <String, dynamic>{
      'status': _$ReaderStatusEnumMap[instance.status],
      'allChapters': instance.allChapters,
    };

const _$ReaderStatusEnumMap = {
  ReaderStatus.Constructed: 'Constructed',
  ReaderStatus.ChaptersLoading: 'ChaptersLoading',
  ReaderStatus.ChaptersLoaded: 'ChaptersLoaded',
  ReaderStatus.Loaded: 'Loaded',
  ReaderStatus.Error: 'Error',
};
