import 'package:json_annotation/json_annotation.dart';

part 'LoginUserRequest.g.dart';

@JsonSerializable()
class LoginUserRequest {

  @JsonKey(name: 'email')
  String Email;
  @JsonKey(name: 'password')
  String Password;

  LoginUserRequest(this.Email, this.Password);

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) => _$LoginUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginUserRequestToJson(this);

}