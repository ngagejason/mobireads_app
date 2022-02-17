import 'package:json_annotation/json_annotation.dart';

part 'confirm_account_request.g.dart';

@JsonSerializable()
class ConfirmAccountRequest {

  @JsonKey(name: 'email')
  String Email;
  @JsonKey(name: 'confirmationCode')
  String ConfirmationCode;

  ConfirmAccountRequest(this.Email, this.ConfirmationCode);

  factory ConfirmAccountRequest.fromJson(Map<String, dynamic> json) => _$ConfirmAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmAccountRequestToJson(this);

}