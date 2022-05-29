import 'package:json_annotation/json_annotation.dart';
import 'OutlineChapter.dart';

part 'OutlineChaptersResponse.g.dart';

@JsonSerializable()
class OutlineChaptersResponse {

  @JsonKey(name: 'chapters')
  final List<OutlineChapter> Chapters;

  OutlineChaptersResponse(this.Chapters);

  factory OutlineChaptersResponse.fromJson(Map<String, dynamic> json) => _$OutlineChaptersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OutlineChaptersResponseToJson(this);
}