// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:json_annotation/json_annotation.dart';

part 'OutlineHash.g.dart';

@JsonSerializable()
class OutlineHash {

  @JsonKey(name: 'id')
  String Id;
  @JsonKey(name: 'hash')
  String? Hash;
  @JsonKey(name: 'index')
  int Index;

  OutlineHash(this.Id, this.Hash, this.Index);

  factory OutlineHash.fromJson(Map<String, dynamic> json) => _$OutlineHashFromJson(json);
  Map<String, dynamic> toJson() => _$OutlineHashToJson(this);
}