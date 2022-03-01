import 'package:json_annotation/json_annotation.dart';

part 'TogglePreferenceRequest.g.dart';

@JsonSerializable()
class TogglePreferenceRequest {

  @JsonKey(name: 'id')
  String Id;
  @JsonKey(name: 'isSelected')
  bool IsSelected;

  TogglePreferenceRequest(this.Id, this.IsSelected);

  factory TogglePreferenceRequest.fromJson(Map<String, dynamic> json) => _$TogglePreferenceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TogglePreferenceRequestToJson(this);
}