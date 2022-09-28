import 'package:json_annotation/json_annotation.dart';

part 'EventLogRequest.g.dart';

@JsonSerializable()
class EventLogRequest {

  @JsonKey(name: 'logType')
  int LogType;
  @JsonKey(name: 'className')
  String ClassName;
  @JsonKey(name: 'methodName')
  String MethodName;
  @JsonKey(name: 'message')
  String Message;


  EventLogRequest(this.LogType, this.ClassName, this.MethodName, this.Message);

  factory EventLogRequest.fromJson(Map<String, dynamic> json) => _$EventLogRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EventLogRequestToJson(this);

}