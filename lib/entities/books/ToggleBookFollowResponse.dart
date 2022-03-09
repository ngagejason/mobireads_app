import 'package:json_annotation/json_annotation.dart';

part 'ToggleBookFollowResponse.g.dart';

@JsonSerializable()
class ToggleBookFollowResponse {

  @JsonKey(name: 'doesFollow')
  bool DoesFollow;
  @JsonKey(name: 'success')
  bool Success;
  @JsonKey(name: 'message')
  String? Message;


  ToggleBookFollowResponse(this.DoesFollow, this.Success, this.Message);

  factory ToggleBookFollowResponse.fromJson(Map<String, dynamic> json) => _$ToggleBookFollowResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ToggleBookFollowResponseToJson(this);
}