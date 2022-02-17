import 'package:json_annotation/json_annotation.dart';

part 'password_reset_request.g.dart';

@JsonSerializable()
class PasswordResetRequest {

  @JsonKey(name: 'email')
  String Email;

  PasswordResetRequest(this.Email);

  factory PasswordResetRequest.fromJson(Map<String, dynamic> json) => _$PasswordResetRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordResetRequestToJson(this);

}