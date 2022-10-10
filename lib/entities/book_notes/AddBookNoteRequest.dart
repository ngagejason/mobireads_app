// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:json_annotation/json_annotation.dart';
part 'AddBookNoteRequest.g.dart';

@JsonSerializable()
class AddBookNoteRequest {
  @JsonKey(name: 'bookId')
  String BookId;
  @JsonKey(name: 'title')
  String Title;
  @JsonKey(name: 'note')
  String Note;

  AddBookNoteRequest(this.BookId, this.Title, this.Note);

  factory AddBookNoteRequest.fromJson(Map<String, dynamic> json) => _$AddBookNoteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddBookNoteRequestToJson(this);
}
