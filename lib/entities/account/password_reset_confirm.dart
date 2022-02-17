import 'package:json_annotation/json_annotation.dart';

part 'password_reset_confirm.g.dart';

@JsonSerializable()
class PasswordResetConfirm {

  @JsonKey(name: 'email')
  String Email;

  @JsonKey(name: 'confirmationCode')
  String ConfirmationCode;

  @JsonKey(name: 'password')
  String Password;

  PasswordResetConfirm(this.Email, this.Password, this.ConfirmationCode);

  factory PasswordResetConfirm.fromJson(Map<String, dynamic> json) => _$PasswordResetConfirmFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordResetConfirmToJson(this);

}