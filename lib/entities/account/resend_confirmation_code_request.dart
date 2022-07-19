import 'package:json_annotation/json_annotation.dart';

part 'resend_confirmation_code_request.g.dart';

@JsonSerializable()
class ResendConfirmationCodeRequest {

  @JsonKey(name: 'email')
  String Email;

  ResendConfirmationCodeRequest(this.Email);

  factory ResendConfirmationCodeRequest.fromJson(Map<String, dynamic> json) => _$ResendConfirmationCodeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ResendConfirmationCodeRequestToJson(this);

}