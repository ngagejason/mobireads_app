import 'package:json_annotation/json_annotation.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineHash.dart';
import 'OutlineChapter.dart';

part 'OutlineHashResponse.g.dart';

@JsonSerializable()
class OutlineHashResponse {

  @JsonKey(name: 'outlineHashes')
  final List<OutlineHash> OutlineHashes;

  OutlineHashResponse(this.OutlineHashes);

  factory OutlineHashResponse.fromJson(Map<String, dynamic> json) => _$OutlineHashResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OutlineHashResponseToJson(this);
}