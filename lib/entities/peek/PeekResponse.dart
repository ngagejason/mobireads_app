// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:mobi_reads/entities/peek/Peek.dart';

part 'PeekResponse.g.dart';

@JsonSerializable()
class PeekResponse {

  @JsonKey(name: 'displayType')
  int DisplayType;
  @JsonKey(name: 'peeks')
  List<Peek>? Peeks;

  PeekResponse(this.Peeks, this.DisplayType);

  factory PeekResponse.fromJson(Map<String, dynamic> json) => _$PeekResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PeekResponseToJson(this);
}