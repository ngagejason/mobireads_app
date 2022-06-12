// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReaderState _$ReaderStateFromJson(Map<String, dynamic> json) => ReaderState(
      status: $enumDecodeNullable(_$ReaderStatusEnumMap, json['status']) ??
          ReaderStatus.Constructed,
      book: json['book'] == null
          ? null
          : Book.fromJson(json['book'] as Map<String, dynamic>),
    )
      ..allChapters = (json['allChapters'] as List<dynamic>)
          .map((e) => OutlineChapter.fromJson(e as Map<String, dynamic>))
          .toList()
      ..reachedEnd = json['reachedEnd'] as bool
      ..scrollOffset = (json['scrollOffset'] as num).toDouble()
      ..fontSize = (json['fontSize'] as num?)?.toDouble();

Map<String, dynamic> _$ReaderStateToJson(ReaderState instance) =>
    <String, dynamic>{
      'status': _$ReaderStatusEnumMap[instance.status],
      'allChapters': instance.allChapters,
      'book': instance.book,
      'reachedEnd': instance.reachedEnd,
      'scrollOffset': instance.scrollOffset,
      'fontSize': instance.fontSize,
    };

const _$ReaderStatusEnumMap = {
  ReaderStatus.Constructed: 'Constructed',
  ReaderStatus.ChaptersLoading: 'ChaptersLoading',
  ReaderStatus.ChaptersLoaded: 'ChaptersLoaded',
  ReaderStatus.Loaded: 'Loaded',
  ReaderStatus.Error: 'Error',
};
