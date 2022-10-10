// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:json_annotation/json_annotation.dart';
part 'BookNote.g.dart';

@JsonSerializable()
class BookNote {
  @JsonKey(name: 'id')
  String Id;
  @JsonKey(name: 'title')
  String? Title = '';
  @JsonKey(name: 'note')
  String? Note = '';
  @JsonKey(name: 'createdDateTimeUTC')
  DateTime CreatedDateTimeUTC;

  BookNote(
      this.Id,
      this.Title,
      this.Note,
      this.CreatedDateTimeUTC);

  factory BookNote.fromJson(Map<String, dynamic> json) => _$BookNoteFromJson(json);
  Map<String, dynamic> toJson() => _$BookNoteToJson(this);
}
