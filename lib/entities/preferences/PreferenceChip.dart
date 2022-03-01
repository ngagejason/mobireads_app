import 'package:json_annotation/json_annotation.dart';

part 'PreferenceChip.g.dart';

@JsonSerializable()
class PreferenceChip {

  @JsonKey(name: 'id')
  String Id;
  @JsonKey(name: 'context')
  String Context;
  @JsonKey(name: 'label')
  String Label;
  @JsonKey(name: 'isSelected')
  bool IsSelected;
  @JsonKey(name: 'code')
  int Code;

  PreferenceChip(this.Id, this.Context, this.Label, this.IsSelected, this.Code);

  factory PreferenceChip.fromJson(Map<String, dynamic> json) => _$PreferenceChipFromJson(json);
  Map<String, dynamic> toJson() => _$PreferenceChipToJson(this);
}