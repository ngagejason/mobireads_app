import 'package:json_annotation/json_annotation.dart';

part 'create_account_request.g.dart';

@JsonSerializable()
class CreateAccountRequest {

  @JsonKey(name: 'email')
  String Email;
  @JsonKey(name: 'username')
  String Username;
  @JsonKey(name: 'password')
  String Password;

  CreateAccountRequest(this.Email, this.Username, this.Password);

  factory CreateAccountRequest.fromJson(Map<String, dynamic> json) => _$CreateAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAccountRequestToJson(this);

}