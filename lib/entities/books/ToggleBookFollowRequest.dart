import 'package:json_annotation/json_annotation.dart';

part 'ToggleBookFollowRequest.g.dart';

@JsonSerializable()
class ToggleBookFollowRequest {

  @JsonKey(name: 'bookId')
  String BookId;

  ToggleBookFollowRequest(this.BookId);

  factory ToggleBookFollowRequest.fromJson(Map<String, dynamic> json) => _$ToggleBookFollowRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ToggleBookFollowRequestToJson(this);
}