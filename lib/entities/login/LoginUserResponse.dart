import 'package:json_annotation/json_annotation.dart';

part 'LoginUserResponse.g.dart';

@JsonSerializable()
class LoginUserResponse {

  @JsonKey(name: 'id')
  String Id;
  @JsonKey(name: 'email')
  String Email;
  @JsonKey(name: 'username')
  String Username;
  @JsonKey(name: 'bearer')
  String Bearer;
  @JsonKey(name: 'success')
  bool Success;
  @JsonKey(name: 'message')
  String? Message;
  @JsonKey(name: 'isGuest')
  bool IsGuest;

  LoginUserResponse(this.Id, this.Email, this.Username, this.Bearer, this.Success, this.Message, this.IsGuest);

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) => _$LoginUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginUserResponseToJson(this);
}