import 'package:json_annotation/json_annotation.dart';

part 'bool_response.g.dart';

@JsonSerializable()
class BoolResponse {

  @JsonKey(name: 'success')
  bool Success;
  @JsonKey(name: 'message')
  String? Message;

  BoolResponse(this.Success, this.Message);

  factory BoolResponse.fromJson(Map<String, dynamic> json) => _$BoolResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoolResponseToJson(this);

}