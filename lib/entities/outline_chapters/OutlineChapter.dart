// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:json_annotation/json_annotation.dart';

part 'OutlineChapter.g.dart';

@JsonSerializable()
class OutlineChapter {

  @JsonKey(name: 'id')
  String Id;
  @JsonKey(name: 'title')
  String? Title;
  @JsonKey(name: 'writing')
  String? Writing;
  @JsonKey(name: 'chapterNumber')
  int ChapterNumber;
  @JsonKey(name: 'deletedDateTimeUTC')
  DateTime? DeletedDateTimeUTC;
  @JsonKey(name: 'hash')
  String? Hash;

  OutlineChapter(this.Id,
      this.Title,
      this.Writing,
      this.ChapterNumber,
      this.DeletedDateTimeUTC,
      this.Hash
      );

  factory OutlineChapter.fromJson(Map<String, dynamic> json) => _$OutlineChapterFromJson(json);
  Map<String, dynamic> toJson() => _$OutlineChapterToJson(this);
}