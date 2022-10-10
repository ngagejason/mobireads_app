// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:json_annotation/json_annotation.dart';
part 'DeleteBookNoteRequest.g.dart';

@JsonSerializable()
class DeleteBookNoteRequest {

  @JsonKey(name: 'id')
  String Id;
  @JsonKey(name: 'bookId')
  String BookId;


  DeleteBookNoteRequest(this.Id, this.BookId);

  factory DeleteBookNoteRequest.fromJson(Map<String, dynamic> json) => _$DeleteBookNoteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteBookNoteRequestToJson(this);
}
