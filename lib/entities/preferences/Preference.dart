import 'package:json_annotation/json_annotation.dart';

part 'Preference.g.dart';

@JsonSerializable()
class Preference {

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
  @JsonKey(name: 'isVisibleInApp')
  bool IsVisibleInApp;
  @JsonKey(name: 'isVisibleInWeb')
  bool IsVisibleInWeb;


  Preference(this.Id, this.Context, this.Label, this.IsSelected, this.Code, this.IsVisibleInApp, this.IsVisibleInWeb);

  factory Preference.fromJson(Map<String, dynamic> json) => _$PreferenceFromJson(json);
  Map<String, dynamic> toJson() => _$PreferenceToJson(this);
}