import 'package:json_annotation/json_annotation.dart';

/// This allows the `RequestResult` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.

part 'RequestResult.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class RequestResult<T> {

  @JsonKey(defaultValue: false, name: 'success')
  bool Success;
  @JsonKey(name: 'message')
  String? Message;
  @JsonKey(name: 'data')
  T? Data;
  @JsonKey(name: 'redirect')
  String? Redirect;

  RequestResult(this.Success, this.Message, this.Data, this.Redirect);

  factory RequestResult.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>  _$RequestResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$RequestResultToJson(this, toJsonT);
}